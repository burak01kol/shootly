/// Fotoğraftan ürünü ayıran arka plan silme servisi.
/// [BackgroundRemover] arayüzü ve cihaz üzerinde (ML Kit / Apple Vision) çalışan uygulamasını içerir.
library;

import 'dart:io';
import 'dart:ui' as ui;

import 'package:native_cutout/native_cutout.dart';

import '../models/cutout.dart';

/// Arka plan silmenin neden başarısız olduğu; ekran bunu seçili dilde anlatır.
enum RemovalFailure { noSubject, failed }

class BackgroundRemovalException implements Exception {
  const BackgroundRemovalException(this.reason, [this.detail]);

  final RemovalFailure reason;

  /// Geliştirici için ham hata ayrıntısı; kullanıcıya gösterilmez.
  final String? detail;

  @override
  String toString() => 'BackgroundRemovalException($reason, $detail)';
}

/// Fotoğraftan ürünü ayıran servis. Testlerde sahte sürümü verilebilir.
abstract interface class BackgroundRemover {
  /// Modeli önceden hazırlar; açılışta çağrılır.
  Future<void> warmUp();

  Future<Cutout> removeBackground(String imagePath);
}

/// Cihaz üzerinde çalışır: Android'de ML Kit, iOS 17+'da Apple Vision.
/// İnternet ve sunucu maliyeti yoktur.
class NativeBackgroundRemover implements BackgroundRemover {
  const NativeBackgroundRemover();

  @override
  Future<void> warmUp() async {
    // Android'de model Google Play Hizmetleri ile iner; ilk fotoğrafı beklememek için.
    if (!await NativeCutout.isModelAvailable()) {
      await NativeCutout.downloadModel();
    }
  }

  @override
  Future<Cutout> removeBackground(String imagePath) async {
    final result = await NativeCutout.removeBackground(
      imagePath,
      options: const CutoutOptions(cropToSubject: true),
    );
    if (result is CutoutFileSuccess) {
      final (width, height) = await _readImageSize(result.path);
      return Cutout(path: result.path, width: width, height: height);
    }
    if (result is CutoutFailure) {
      throw BackgroundRemovalException(
        result.code == CutoutErrorCode.noSubjectFound
            ? RemovalFailure.noSubject
            : RemovalFailure.failed,
        result.message,
      );
    }
    throw const BackgroundRemovalException(RemovalFailure.failed);
  }

  static Future<(int, int)> _readImageSize(String path) async {
    final bytes = await File(path).readAsBytes();
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final size = (descriptor.width, descriptor.height);
    descriptor.dispose();
    buffer.dispose();
    return size;
  }
}
