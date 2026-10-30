/// Uygulama genelindeki sabitler: RevenueCat anahtarları, entitlement kimliği,
/// ücretsiz plan limiti, ürün başına fotoğraf sınırı ve galeri albümü adı.
library;

/// Uygulama genelindeki sabit ayarlar.
abstract final class AppConfig {
  static const appName = 'Shootly';

  /// Ayarlar ekranında gösterilen sürüm; pubspec.yaml `version` ile aynı tutulmalı.
  static const appVersion = '1.0.0';

  /// RevenueCat public API anahtarları. Derlerken verilir:
  /// `flutter run --dart-define=RC_ANDROID_KEY=goog_xxx`
  /// Boş kalırsa uygulama geliştirme modunda çalışır (bkz. DevSubscriptionService).
  static const revenueCatAndroidKey = String.fromEnvironment('RC_ANDROID_KEY');
  static const revenueCatIosKey = String.fromEnvironment('RC_IOS_KEY');

  /// RevenueCat panelindeki entitlement kimliği.
  static const proEntitlementId = 'pro';

  /// Ücretsiz planda günlük dışa aktarma hakkı.
  static const freeDailyExports = 3;

  /// Bir üründe işlenebilecek en fazla fotoğraf (Trendyol sınırı).
  static const maxPhotosPerProduct = 8;

  /// Fotoğrafların kaydedileceği galeri albümü.
  static const galleryAlbum = 'Shootly';

  /// GitHub Pages adresi; sayfalar depodaki docs/ klasöründen yayınlanır.
  static const _webBase = 'https://burak01kol.github.io/shootly';

  /// Gizlilik politikası sayfası (docs/privacy.html, GitHub Pages).
  static const privacyPolicyUrl = '$_webBase/privacy.html';

  /// Destek sayfası (docs/index.html, GitHub Pages).
  static const supportUrl = '$_webBase/';

  /// Abonelikler için Apple'ın standart kullanım koşulları (EULA).
  static const termsOfUseUrl =
      'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';
}
