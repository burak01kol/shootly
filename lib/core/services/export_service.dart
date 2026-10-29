/// Kesilmiş fotoğrafları pazaryerine hazır `barkod_N.jpg` dosyalarına dönüştürür.
/// Üretilen dosyaları galeriye kaydetme ve paylaşma işlemleri de bu serviste.
library;

import 'dart:io';

import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../config/app_config.dart';
import '../models/cutout.dart';
import '../models/export_settings.dart';
import 'image_composer.dart';

/// Galeriye kaydetmenin sonucu; ekran buna göre mesaj ve buton gösterir.
enum GallerySaveResult { saved, denied, failed }

/// Kesilmiş fotoğrafları pazaryerine hazır JPG dosyalarına çevirir,
/// galeriye kaydeder ve paylaşır.
class ExportService {
  const ExportService(this._composer);

  final ImageComposer _composer;

  /// Dosyaları `<barkod>_1.jpg`, `<barkod>_2.jpg` ... olarak üretir.
  Future<List<File>> export({
    required List<Cutout> cutouts,
    required ExportSettings settings,
    required String baseName,
  }) async {
    final outputDir = await _createOutputDir();
    final name = fileBaseName(baseName);
    final files = <File>[];

    for (var i = 0; i < cutouts.length; i++) {
      final canvas = settings.canvasFor(cutouts[i]);
      final jpg = await _composer.compose(
        ComposeRequest(
          cutoutPng: await File(cutouts[i].path).readAsBytes(),
          width: canvas.width,
          height: canvas.height,
          fill: canvas.fill,
          backgroundArgb: settings.backdrop.argb,
          shadow: settings.shadow,
        ),
      );
      final file = File('${outputDir.path}/${name}_${i + 1}.jpg');
      files.add(await file.writeAsBytes(jpg));
    }
    return files;
  }

  /// Görselleri Shootly albümüne kaydeder; izin yoksa önce sistem iznini ister.
  Future<GallerySaveResult> saveToGallery(List<File> files) async {
    try {
      if (!await Gal.hasAccess(toAlbum: true) &&
          !await Gal.requestAccess(toAlbum: true)) {
        return GallerySaveResult.denied;
      }
      for (final file in files) {
        await Gal.putImage(file.path, album: AppConfig.galleryAlbum);
      }
      return GallerySaveResult.saved;
    } on GalException catch (error) {
      return error.type == GalExceptionType.accessDenied
          ? GallerySaveResult.denied
          : GallerySaveResult.failed;
    } catch (_) {
      return GallerySaveResult.failed;
    }
  }

  Future<void> share(List<File> files) async {
    await SharePlus.instance.share(
      ShareParams(files: [for (final file in files) XFile(file.path)]),
    );
  }

  /// Dosya adında sorun çıkaracak karakterleri temizler.
  static String fileBaseName(String input) {
    final cleaned = input.trim().replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '');
    return cleaned.isEmpty ? 'urun' : cleaned;
  }

  static Future<Directory> _createOutputDir() async {
    final temp = await getTemporaryDirectory();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    return Directory('${temp.path}/exports/$stamp').create(recursive: true);
  }
}
