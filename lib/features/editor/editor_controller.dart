/// Düzenleme ekranının durum yöneticisi (`ChangeNotifier`).
/// Fotoğrafları sırayla arka plan silmeden geçirir, hataları ve seçili dışa aktarma ayarlarını tutar.
library;

import 'package:flutter/foundation.dart';

import '../../core/models/cutout.dart';
import '../../core/models/export_settings.dart';
import '../../core/services/background_remover.dart';

enum PhotoStatus { processing, ready, failed }

@immutable
class EditorPhoto {
  const EditorPhoto({
    required this.sourcePath,
    this.cutout,
    this.status = PhotoStatus.processing,
    this.error,
  });

  final String sourcePath;
  final Cutout? cutout;
  final PhotoStatus status;
  final String? error;

  EditorPhoto copyWith({Cutout? cutout, PhotoStatus? status, String? error}) {
    return EditorPhoto(
      sourcePath: sourcePath,
      cutout: cutout ?? this.cutout,
      status: status ?? this.status,
      error: error,
    );
  }
}

/// Düzenleme ekranının durumu: fotoğrafların işlenmesi ve seçili ayarlar.
class EditorController extends ChangeNotifier {
  EditorController({
    required BackgroundRemover remover,
    required List<String> sourcePaths,
    ExportSettings initialSettings = const ExportSettings(),
  })  : assert(sourcePaths.isNotEmpty),
        _remover = remover,
        _settings = initialSettings,
        _photos = [for (final path in sourcePaths) EditorPhoto(sourcePath: path)];

  final BackgroundRemover _remover;
  final List<EditorPhoto> _photos;
  ExportSettings _settings;
  int _selectedIndex = 0;
  bool _disposed = false;

  List<EditorPhoto> get photos => List.unmodifiable(_photos);
  ExportSettings get settings => _settings;
  int get selectedIndex => _selectedIndex;
  EditorPhoto get selected => _photos[_selectedIndex];

  bool get isProcessing =>
      _photos.any((photo) => photo.status == PhotoStatus.processing);

  List<Cutout> get readyCutouts => [
        for (final photo in _photos)
          if (photo.status == PhotoStatus.ready && photo.cutout != null)
            photo.cutout!,
      ];

  /// Fotoğrafları sırayla işler (bellek kullanımını düşük tutar).
  Future<void> processAll() async {
    for (var i = 0; i < _photos.length; i++) {
      await _process(i);
    }
  }

  Future<void> retry(int index) async {
    _replace(index, _photos[index].copyWith(status: PhotoStatus.processing));
    await _process(index);
  }

  void select(int index) {
    if (index == _selectedIndex) return;
    _selectedIndex = index;
    _notify();
  }

  void updateSettings(ExportSettings settings) {
    _settings = settings;
    _notify();
  }

  Future<void> _process(int index) async {
    try {
      final cutout = await _remover.removeBackground(_photos[index].sourcePath);
      _replace(
        index,
        _photos[index].copyWith(cutout: cutout, status: PhotoStatus.ready),
      );
    } on BackgroundRemovalException catch (error) {
      _fail(index, error.message);
    } catch (_) {
      _fail(index, 'Fotoğraf işlenemedi. Tekrar dene.');
    }
  }

  void _fail(int index, String message) {
    _replace(
      index,
      _photos[index].copyWith(status: PhotoStatus.failed, error: message),
    );
  }

  void _replace(int index, EditorPhoto photo) {
    _photos[index] = photo;
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
