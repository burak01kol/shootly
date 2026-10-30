/// [LanguageController] için birim testleri: varsayılanın Türkçe olması,
/// seçimin kaydedilmesi ve tanınmayan kodda Türkçe'ye dönülmesi.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitrin/core/services/app_preferences.dart';
import 'package:vitrin/core/services/language_controller.dart';

void main() {
  Future<AppPreferences> preferences([Map<String, Object> values = const {}]) async {
    SharedPreferences.setMockInitialValues(values);
    return AppPreferences(await SharedPreferences.getInstance());
  }

  test('varsayılan dil Türkçe', () async {
    final controller = LanguageController(await preferences());
    expect(controller.language, AppLanguage.turkish);
  });

  test('seçilen dil kaydedilir ve sonraki açılışta gelir', () async {
    final prefs = await preferences();
    await LanguageController(prefs).select(AppLanguage.english);
    expect(prefs.languageCode, 'en');
    expect(LanguageController(prefs).language, AppLanguage.english);
  });

  test('tanınmayan dil kodunda Türkçe kullanılır', () async {
    final controller = LanguageController(await preferences({'app.language': 'de'}));
    expect(controller.language, AppLanguage.turkish);
  });
}
