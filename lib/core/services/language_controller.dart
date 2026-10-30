/// Uygulama dilinin (Türkçe / İngilizce) seçimini tutan ve saklayan denetleyici.
/// Varsayılan Türkçe'dir; değişince MaterialApp yeniden çizilir.
library;

import 'package:flutter/widgets.dart';

import 'app_preferences.dart';

/// Desteklenen diller; ekranda her biri kendi dilinde yazılır.
enum AppLanguage {
  turkish('tr', 'Türkçe'),
  english('en', 'English');

  const AppLanguage(this.code, this.nativeName);

  final String code;
  final String nativeName;

  Locale get locale => Locale(code);

  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
        (language) => language.code == code,
        orElse: () => AppLanguage.turkish,
      );
}

class LanguageController extends ChangeNotifier {
  LanguageController(this._preferences)
      : _language = AppLanguage.fromCode(_preferences.languageCode);

  final AppPreferences _preferences;
  AppLanguage _language;

  AppLanguage get language => _language;

  Future<void> select(AppLanguage language) async {
    if (language == _language) return;
    _language = language;
    notifyListeners();
    await _preferences.saveLanguageCode(language.code);
  }
}
