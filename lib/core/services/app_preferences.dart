/// Küçük, kalıcı kullanıcı tercihlerinin servisi (`SharedPreferences`).
/// Onboarding'in görülüp görülmediğini ve son kullanılan dışa aktarma ayarlarını saklar.
library;

import 'package:shared_preferences/shared_preferences.dart';

import '../models/backdrop.dart';
import '../models/canvas_size.dart';
import '../models/export_settings.dart';
import '../models/marketplace.dart';

class AppPreferences {
  const AppPreferences(this._prefs);

  static const _onboardingKey = 'onboarding.seen';
  static const _sizeModeKey = 'export.sizeMode';
  static const _marketplaceKey = 'export.marketplace';
  static const _customWidthKey = 'export.customWidth';
  static const _customHeightKey = 'export.customHeight';
  static const _backdropKey = 'export.backdrop';
  static const _shadowKey = 'export.shadow';

  final SharedPreferences _prefs;

  bool get onboardingSeen => _prefs.getBool(_onboardingKey) ?? false;

  Future<void> markOnboardingSeen() => _prefs.setBool(_onboardingKey, true);

  Future<void> resetOnboarding() => _prefs.remove(_onboardingKey);

  /// Son kaydedilen ayarlar; hiç kaydedilmemiş ya da bozuk alanlar varsayılana döner.
  ExportSettings get lastExportSettings {
    const fallback = ExportSettings();
    final width = _prefs.getInt(_customWidthKey);
    final height = _prefs.getInt(_customHeightKey);
    return ExportSettings(
      sizeMode: _byName(SizeMode.values, _sizeModeKey) ?? fallback.sizeMode,
      marketplace:
          _byName(Marketplace.values, _marketplaceKey) ?? fallback.marketplace,
      customWidth:
          CanvasSize.isValidSide(width) ? width! : fallback.customWidth,
      customHeight:
          CanvasSize.isValidSide(height) ? height! : fallback.customHeight,
      backdrop: _byName(Backdrop.values, _backdropKey) ?? fallback.backdrop,
      shadow: _prefs.getBool(_shadowKey) ?? fallback.shadow,
    );
  }

  Future<void> saveExportSettings(ExportSettings settings) async {
    await _prefs.setString(_sizeModeKey, settings.sizeMode.name);
    await _prefs.setString(_marketplaceKey, settings.marketplace.name);
    await _prefs.setInt(_customWidthKey, settings.customWidth);
    await _prefs.setInt(_customHeightKey, settings.customHeight);
    await _prefs.setString(_backdropKey, settings.backdrop.name);
    await _prefs.setBool(_shadowKey, settings.shadow);
  }

  T? _byName<T extends Enum>(List<T> values, String key) {
    final name = _prefs.getString(key);
    for (final value in values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
