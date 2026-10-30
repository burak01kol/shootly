/// Otomatik üretilmiş çeviri kodu (flutter gen-l10n); elle düzenlemeyin.
/// Metinler lib/l10n/app_tr.arb ve app_en.arb dosyalarındadır.
library;

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get proUpgrade => 'Pro\'ya geç';

  @override
  String get proBadge => 'PRO';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get share => 'Paylaş';

  @override
  String get close => 'Kapat';

  @override
  String get settings => 'Ayarlar';

  @override
  String get homeHeadline => 'Çek.\nGerisini Shootly\nhalleder.';

  @override
  String get homeSubtitle =>
      'Arka plan silinir, ürün beyaz zemine oturur ve pazaryeri ölçüsünde kaydedilir.';

  @override
  String get shutterTapToShoot => 'Dokun ve çek';

  @override
  String get shutterPickPhoto => 'Fotoğraf seç';

  @override
  String get pickFromGallery => 'Galeriden seç';

  @override
  String pickFromGalleryMax(int count) {
    return 'Galeriden seç (en fazla $count)';
  }

  @override
  String get photoPickFailed => 'Fotoğraf alınamadı. Tekrar dene.';

  @override
  String usageRemaining(int count) {
    return 'Bugün $count ücretsiz hakkın var';
  }

  @override
  String get usageExhausted => 'Bugünkü hakların bitti, yarın yenilenir';

  @override
  String get usageUpgrade => 'Sınırsız yap';

  @override
  String get devModeNote =>
      'Geliştirme modu: \"Pro\'ya geç\" ödeme almadan Pro\'yu açar.';

  @override
  String get onboardingSkip => 'Geç';

  @override
  String get onboardingNext => 'Devam';

  @override
  String get onboardingStart => 'Hadi başlayalım';

  @override
  String get onboarding1Title => 'Tek dokunuşla çek.';

  @override
  String get onboarding1Body =>
      'Ürününü telefonunla çek ya da galeriden seç. Hepsi bu kadar.';

  @override
  String get onboarding2Title => 'Arka plan saniyede gider.';

  @override
  String get onboarding2Body =>
      'Yapay zekâ ürünü ayırır ve temiz beyaz zemine oturtur. İnternet gerekmez.';

  @override
  String get onboarding3Title => 'Pazaryerine hazır.';

  @override
  String get onboarding3Body =>
      'Trendyol, Hepsiburada, n11 ve Amazon ölçülerinde, barkodla adlandırılıp galerine kaydedilir.';

  @override
  String get editorTitleSingle => 'Önizleme';

  @override
  String editorTitleMultiple(int count) {
    return '$count fotoğraf';
  }

  @override
  String get barcodeHint => 'Barkod veya ürün kodu (isteğe bağlı)';

  @override
  String get exportFailed => 'Görseller hazırlanamadı. Tekrar dene.';

  @override
  String get buttonRemoving => 'Arka plan siliniyor…';

  @override
  String get buttonPreparing => 'Hazırlanıyor…';

  @override
  String get buttonNoReady => 'Hazır fotoğraf yok';

  @override
  String get buttonExport => 'Hazırla ve kaydet';

  @override
  String buttonExportCount(int count) {
    return 'Hazırla ve kaydet ($count)';
  }

  @override
  String get removalNoSubject =>
      'Fotoğrafta ürün bulunamadı. Ürünü ortalayıp tekrar çek.';

  @override
  String get removalFailed => 'Fotoğraf işlenemedi. Tekrar dene.';

  @override
  String get sectionSize => 'ÖLÇÜ';

  @override
  String get sectionBackdrop => 'ZEMİN';

  @override
  String get sizeOriginal => 'Orijinal';

  @override
  String get sizeCustom => 'Özel';

  @override
  String get sizeMatchesProduct => 'Ürün oranında';

  @override
  String get floorShadow => 'Zemin gölgesi';

  @override
  String get backdropWhite => 'Beyaz';

  @override
  String get backdropLightGrey => 'Açık gri';

  @override
  String get backdropCream => 'Krem';

  @override
  String get backdropSky => 'Mavi';

  @override
  String get backdropBlush => 'Pembe';

  @override
  String get backdropBlack => 'Siyah';

  @override
  String get customSizeTitle => 'Özel ölçü';

  @override
  String get customSizeSubtitle =>
      'Hazır bir oran seç ya da ölçüyü kendin yaz.';

  @override
  String get presetSquare => 'Kare';

  @override
  String get presetVertical => 'Dikey';

  @override
  String get presetPortrait => 'Portre';

  @override
  String get presetStory => 'Hikâye';

  @override
  String get presetLandscape => 'Yatay';

  @override
  String get sizeWidth => 'Genişlik';

  @override
  String get sizeHeight => 'Yükseklik';

  @override
  String customSizeRange(int min, int max) {
    return 'Her kenar $min–$max piksel arasında olmalı.';
  }

  @override
  String get apply => 'Uygula';

  @override
  String get resultTitle => 'Hazır!';

  @override
  String resultSaved(int count, String album) {
    return '$count görsel galerinde, $album albümünde.';
  }

  @override
  String resultDenied(int count) {
    return '$count görsel hazır. Galeriye kaydetmek için izin gerekiyor; istersen \"Paylaş\" ile de gönderebilirsin.';
  }

  @override
  String resultFailed(int count) {
    return '$count görsel hazır, ancak galeriye kaydedilemedi.';
  }

  @override
  String get grantAndSave => 'İzin ver ve kaydet';

  @override
  String get retrySave => 'Tekrar kaydet';

  @override
  String get newShoot => 'Yeni çekim';

  @override
  String get proActive => 'Shootly Pro aktif';

  @override
  String get proTitle => 'Shootly Pro';

  @override
  String get perkUnlimited => 'Sınırsız günlük çekim';

  @override
  String get perkSizes => 'Tüm pazaryeri ölçüleri ve özel ölçü';

  @override
  String get perkBackdrops => 'Renkli zeminler ve zemin gölgesi';

  @override
  String perkBatch(int count) {
    return 'Tek seferde $count fotoğraf';
  }

  @override
  String get subscriptionTerms =>
      'Abonelik, dönem bitmeden en az 24 saat önce iptal edilmezse otomatik yenilenir. App Store hesap ayarlarından yönetebilir ve iptal edebilirsin.';

  @override
  String get groupAccount => 'HESAP';

  @override
  String get restorePurchases => 'Satın alımları geri yükle';

  @override
  String get restoreSuccess => 'Pro aboneliğin geri yüklendi.';

  @override
  String get restoreNone => 'Geri yüklenecek bir abonelik bulunamadı.';

  @override
  String get groupLegal => 'YASAL VE DESTEK';

  @override
  String get privacyPolicy => 'Gizlilik politikası';

  @override
  String get termsOfUse => 'Kullanım koşulları';

  @override
  String get support => 'Destek';

  @override
  String get linkFailed => 'Bağlantı açılamadı.';

  @override
  String get groupApp => 'UYGULAMA';

  @override
  String get language => 'Dil';

  @override
  String get replayOnboarding => 'Tanıtımı tekrar göster';

  @override
  String get version => 'Sürüm';

  @override
  String get privacyNote =>
      'Fotoğrafların cihazında işlenir; hiçbir sunucuya gönderilmez.';

  @override
  String get permCameraTitle => 'Kamera izni kapalı';

  @override
  String get permCameraBody =>
      'Ürün fotoğrafı çekebilmek için Shootly\'nin kameraya erişmesi gerekiyor. Fotoğraflar yalnızca cihazında işlenir, hiçbir yere gönderilmez.';

  @override
  String get permPhotosTitle => 'Fotoğraflara erişim kapalı';

  @override
  String get permPhotosBody =>
      'Galeriden ürün fotoğrafı seçebilmek için fotoğraflarına erişim izni gerekiyor.';

  @override
  String get permSaveTitle => 'Galeriye kaydetme izni kapalı';

  @override
  String get permSaveBody =>
      'Hazırlanan görselleri galerine kaydedebilmek için izin gerekiyor. İzin vermesen de görselleri \"Paylaş\" ile gönderebilirsin.';

  @override
  String get openSettings => 'Ayarları aç';

  @override
  String get notNow => 'Şimdi değil';
}
