/// [ExportService.fileBaseName] dosya adı temizleme, [ExportSettings.needsPro]
/// Pro kontrolü ve [ExportSettings.canvasFor] ölçü hesabı için birim testleri.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vitrin/core/models/backdrop.dart';
import 'package:vitrin/core/models/canvas_size.dart';
import 'package:vitrin/core/models/cutout.dart';
import 'package:vitrin/core/models/export_settings.dart';
import 'package:vitrin/core/models/marketplace.dart';
import 'package:vitrin/core/services/export_service.dart';

void main() {
  group('ExportService.fileBaseName', () {
    test('barkodu olduğu gibi kullanır', () {
      expect(ExportService.fileBaseName('8690000000001'), '8690000000001');
    });

    test('boşluk ve özel karakterleri temizler', () {
      expect(ExportService.fileBaseName(' AB-12/ş 3 '), 'AB-123');
    });

    test('boşsa varsayılan ad verir', () {
      expect(ExportService.fileBaseName('   '), 'urun');
    });
  });

  group('ExportSettings.needsPro', () {
    test('varsayılan ayarlar ücretsiz', () {
      expect(const ExportSettings().needsPro, isFalse);
    });

    test('Pro pazaryeri, renk veya gölge Pro ister', () {
      const base = ExportSettings();
      expect(base.copyWith(marketplace: Marketplace.amazon).needsPro, isTrue);
      expect(base.copyWith(backdrop: Backdrop.cream).needsPro, isTrue);
      expect(base.copyWith(shadow: true).needsPro, isTrue);
    });

    test('Orijinal ölçü ücretsiz, özel ölçü Pro ister', () {
      const base = ExportSettings();
      expect(base.copyWith(sizeMode: SizeMode.original).needsPro, isFalse);
      expect(base.copyWith(sizeMode: SizeMode.custom).needsPro, isTrue);
    });

    test('Orijinal modda kilitli pazaryeri seçili kalsa da Pro istemez', () {
      const settings = ExportSettings(
        sizeMode: SizeMode.original,
        marketplace: Marketplace.amazon,
      );
      expect(settings.needsPro, isFalse);
    });
  });

  group('ExportSettings.canvasFor', () {
    const tall = Cutout(path: 'x.png', width: 300, height: 600);
    const wide = Cutout(path: 'x.png', width: 800, height: 200);

    test('pazaryeri ölçüsünü kullanır', () {
      final canvas = const ExportSettings().canvasFor(tall);
      expect((canvas.width, canvas.height), (1200, 1800));
    });

    test('özel ölçüyü kullanır', () {
      const settings = ExportSettings(
        sizeMode: SizeMode.custom,
        customWidth: 1080,
        customHeight: 1920,
      );
      final canvas = settings.canvasFor(tall);
      expect((canvas.width, canvas.height), (1080, 1920));
    });

    test('orijinal ölçü ürün oranında, uzun kenar 2000 px', () {
      const settings = ExportSettings(sizeMode: SizeMode.original);
      final portrait = settings.canvasFor(tall);
      final landscape = settings.canvasFor(wide);
      expect((portrait.width, portrait.height), (1000, 2000));
      expect((landscape.width, landscape.height), (2000, 500));
    });
  });

  test('CanvasSize.isValidSide sınırları uygular', () {
    expect(CanvasSize.isValidSide(199), isFalse);
    expect(CanvasSize.isValidSide(200), isTrue);
    expect(CanvasSize.isValidSide(5000), isTrue);
    expect(CanvasSize.isValidSide(5001), isFalse);
    expect(CanvasSize.isValidSide(null), isFalse);
  });
}
