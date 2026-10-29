/// [AppPreferences] için birim testleri: son dışa aktarma ayarlarının
/// kaydedilip geri okunması, eksik veya bozuk değerlerde varsayılana dönülmesi.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitrin/core/models/backdrop.dart';
import 'package:vitrin/core/models/canvas_size.dart';
import 'package:vitrin/core/models/export_settings.dart';
import 'package:vitrin/core/models/marketplace.dart';
import 'package:vitrin/core/services/app_preferences.dart';

void main() {
  Future<AppPreferences> preferences([Map<String, Object> values = const {}]) async {
    SharedPreferences.setMockInitialValues(values);
    return AppPreferences(await SharedPreferences.getInstance());
  }

  test('hiç kayıt yoksa varsayılan ayarlar döner', () async {
    final prefs = await preferences();
    expect(prefs.lastExportSettings, const ExportSettings());
  });

  test('kaydedilen ayarlar aynen geri okunur', () async {
    final prefs = await preferences();
    const settings = ExportSettings(
      sizeMode: SizeMode.custom,
      marketplace: Marketplace.amazon,
      customWidth: 1080,
      customHeight: 1920,
      backdrop: Backdrop.cream,
      shadow: true,
    );
    await prefs.saveExportSettings(settings);
    expect(prefs.lastExportSettings, settings);
  });

  test('bozuk değerler varsayılana döner', () async {
    final prefs = await preferences({
      'export.sizeMode': 'yok-boyle-bir-mod',
      'export.customWidth': 99999,
      'export.backdrop': 'mor',
    });
    final settings = prefs.lastExportSettings;
    expect(settings.sizeMode, SizeMode.marketplace);
    expect(settings.customWidth, const ExportSettings().customWidth);
    expect(settings.backdrop, Backdrop.white);
  });

  test('tanıtım sıfırlanınca tekrar gösterilir', () async {
    final prefs = await preferences();
    await prefs.markOnboardingSeen();
    expect(prefs.onboardingSeen, isTrue);
    await prefs.resetOnboarding();
    expect(prefs.onboardingSeen, isFalse);
  });
}
