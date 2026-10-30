/// Otomatik üretilmiş çeviri kodu (flutter gen-l10n); elle düzenlemeyin.
/// Metinler lib/l10n/app_tr.arb ve app_en.arb dosyalarındadır.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @proUpgrade.
  ///
  /// In tr, this message translates to:
  /// **'Pro\'ya geç'**
  String get proUpgrade;

  /// No description provided for @proBadge.
  ///
  /// In tr, this message translates to:
  /// **'PRO'**
  String get proBadge;

  /// No description provided for @retry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get retry;

  /// No description provided for @share.
  ///
  /// In tr, this message translates to:
  /// **'Paylaş'**
  String get share;

  /// No description provided for @close.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get close;

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settings;

  /// No description provided for @homeHeadline.
  ///
  /// In tr, this message translates to:
  /// **'Çek.\nGerisini Shootly\nhalleder.'**
  String get homeHeadline;

  /// No description provided for @homeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Arka plan silinir, ürün beyaz zemine oturur ve pazaryeri ölçüsünde kaydedilir.'**
  String get homeSubtitle;

  /// No description provided for @shutterTapToShoot.
  ///
  /// In tr, this message translates to:
  /// **'Dokun ve çek'**
  String get shutterTapToShoot;

  /// No description provided for @shutterPickPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf seç'**
  String get shutterPickPhoto;

  /// No description provided for @pickFromGallery.
  ///
  /// In tr, this message translates to:
  /// **'Galeriden seç'**
  String get pickFromGallery;

  /// No description provided for @pickFromGalleryMax.
  ///
  /// In tr, this message translates to:
  /// **'Galeriden seç (en fazla {count})'**
  String pickFromGalleryMax(int count);

  /// No description provided for @photoPickFailed.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf alınamadı. Tekrar dene.'**
  String get photoPickFailed;

  /// No description provided for @usageRemaining.
  ///
  /// In tr, this message translates to:
  /// **'Bugün {count} ücretsiz hakkın var'**
  String usageRemaining(int count);

  /// No description provided for @usageExhausted.
  ///
  /// In tr, this message translates to:
  /// **'Bugünkü hakların bitti, yarın yenilenir'**
  String get usageExhausted;

  /// No description provided for @usageUpgrade.
  ///
  /// In tr, this message translates to:
  /// **'Sınırsız yap'**
  String get usageUpgrade;

  /// No description provided for @devModeNote.
  ///
  /// In tr, this message translates to:
  /// **'Geliştirme modu: \"Pro\'ya geç\" ödeme almadan Pro\'yu açar.'**
  String get devModeNote;

  /// No description provided for @onboardingSkip.
  ///
  /// In tr, this message translates to:
  /// **'Geç'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In tr, this message translates to:
  /// **'Hadi başlayalım'**
  String get onboardingStart;

  /// No description provided for @onboarding1Title.
  ///
  /// In tr, this message translates to:
  /// **'Tek dokunuşla çek.'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In tr, this message translates to:
  /// **'Ürününü telefonunla çek ya da galeriden seç. Hepsi bu kadar.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In tr, this message translates to:
  /// **'Arka plan saniyede gider.'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In tr, this message translates to:
  /// **'Yapay zekâ ürünü ayırır ve temiz beyaz zemine oturtur. İnternet gerekmez.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In tr, this message translates to:
  /// **'Pazaryerine hazır.'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In tr, this message translates to:
  /// **'Trendyol, Hepsiburada, n11 ve Amazon ölçülerinde, barkodla adlandırılıp galerine kaydedilir.'**
  String get onboarding3Body;

  /// No description provided for @editorTitleSingle.
  ///
  /// In tr, this message translates to:
  /// **'Önizleme'**
  String get editorTitleSingle;

  /// No description provided for @editorTitleMultiple.
  ///
  /// In tr, this message translates to:
  /// **'{count} fotoğraf'**
  String editorTitleMultiple(int count);

  /// No description provided for @barcodeHint.
  ///
  /// In tr, this message translates to:
  /// **'Barkod veya ürün kodu (isteğe bağlı)'**
  String get barcodeHint;

  /// No description provided for @exportFailed.
  ///
  /// In tr, this message translates to:
  /// **'Görseller hazırlanamadı. Tekrar dene.'**
  String get exportFailed;

  /// No description provided for @buttonRemoving.
  ///
  /// In tr, this message translates to:
  /// **'Arka plan siliniyor…'**
  String get buttonRemoving;

  /// No description provided for @buttonPreparing.
  ///
  /// In tr, this message translates to:
  /// **'Hazırlanıyor…'**
  String get buttonPreparing;

  /// No description provided for @buttonNoReady.
  ///
  /// In tr, this message translates to:
  /// **'Hazır fotoğraf yok'**
  String get buttonNoReady;

  /// No description provided for @buttonExport.
  ///
  /// In tr, this message translates to:
  /// **'Hazırla ve kaydet'**
  String get buttonExport;

  /// No description provided for @buttonExportCount.
  ///
  /// In tr, this message translates to:
  /// **'Hazırla ve kaydet ({count})'**
  String buttonExportCount(int count);

  /// No description provided for @removalNoSubject.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafta ürün bulunamadı. Ürünü ortalayıp tekrar çek.'**
  String get removalNoSubject;

  /// No description provided for @removalFailed.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraf işlenemedi. Tekrar dene.'**
  String get removalFailed;

  /// No description provided for @sectionSize.
  ///
  /// In tr, this message translates to:
  /// **'ÖLÇÜ'**
  String get sectionSize;

  /// No description provided for @sectionBackdrop.
  ///
  /// In tr, this message translates to:
  /// **'ZEMİN'**
  String get sectionBackdrop;

  /// No description provided for @sizeOriginal.
  ///
  /// In tr, this message translates to:
  /// **'Orijinal'**
  String get sizeOriginal;

  /// No description provided for @sizeCustom.
  ///
  /// In tr, this message translates to:
  /// **'Özel'**
  String get sizeCustom;

  /// No description provided for @sizeMatchesProduct.
  ///
  /// In tr, this message translates to:
  /// **'Ürün oranında'**
  String get sizeMatchesProduct;

  /// No description provided for @floorShadow.
  ///
  /// In tr, this message translates to:
  /// **'Zemin gölgesi'**
  String get floorShadow;

  /// No description provided for @backdropWhite.
  ///
  /// In tr, this message translates to:
  /// **'Beyaz'**
  String get backdropWhite;

  /// No description provided for @backdropLightGrey.
  ///
  /// In tr, this message translates to:
  /// **'Açık gri'**
  String get backdropLightGrey;

  /// No description provided for @backdropCream.
  ///
  /// In tr, this message translates to:
  /// **'Krem'**
  String get backdropCream;

  /// No description provided for @backdropSky.
  ///
  /// In tr, this message translates to:
  /// **'Mavi'**
  String get backdropSky;

  /// No description provided for @backdropBlush.
  ///
  /// In tr, this message translates to:
  /// **'Pembe'**
  String get backdropBlush;

  /// No description provided for @backdropBlack.
  ///
  /// In tr, this message translates to:
  /// **'Siyah'**
  String get backdropBlack;

  /// No description provided for @customSizeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Özel ölçü'**
  String get customSizeTitle;

  /// No description provided for @customSizeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Hazır bir oran seç ya da ölçüyü kendin yaz.'**
  String get customSizeSubtitle;

  /// No description provided for @presetSquare.
  ///
  /// In tr, this message translates to:
  /// **'Kare'**
  String get presetSquare;

  /// No description provided for @presetVertical.
  ///
  /// In tr, this message translates to:
  /// **'Dikey'**
  String get presetVertical;

  /// No description provided for @presetPortrait.
  ///
  /// In tr, this message translates to:
  /// **'Portre'**
  String get presetPortrait;

  /// No description provided for @presetStory.
  ///
  /// In tr, this message translates to:
  /// **'Hikâye'**
  String get presetStory;

  /// No description provided for @presetLandscape.
  ///
  /// In tr, this message translates to:
  /// **'Yatay'**
  String get presetLandscape;

  /// No description provided for @sizeWidth.
  ///
  /// In tr, this message translates to:
  /// **'Genişlik'**
  String get sizeWidth;

  /// No description provided for @sizeHeight.
  ///
  /// In tr, this message translates to:
  /// **'Yükseklik'**
  String get sizeHeight;

  /// No description provided for @customSizeRange.
  ///
  /// In tr, this message translates to:
  /// **'Her kenar {min}–{max} piksel arasında olmalı.'**
  String customSizeRange(int min, int max);

  /// No description provided for @apply.
  ///
  /// In tr, this message translates to:
  /// **'Uygula'**
  String get apply;

  /// No description provided for @resultTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hazır!'**
  String get resultTitle;

  /// No description provided for @resultSaved.
  ///
  /// In tr, this message translates to:
  /// **'{count} görsel galerinde, {album} albümünde.'**
  String resultSaved(int count, String album);

  /// No description provided for @resultDenied.
  ///
  /// In tr, this message translates to:
  /// **'{count} görsel hazır. Galeriye kaydetmek için izin gerekiyor; istersen \"Paylaş\" ile de gönderebilirsin.'**
  String resultDenied(int count);

  /// No description provided for @resultFailed.
  ///
  /// In tr, this message translates to:
  /// **'{count} görsel hazır, ancak galeriye kaydedilemedi.'**
  String resultFailed(int count);

  /// No description provided for @grantAndSave.
  ///
  /// In tr, this message translates to:
  /// **'İzin ver ve kaydet'**
  String get grantAndSave;

  /// No description provided for @retrySave.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar kaydet'**
  String get retrySave;

  /// No description provided for @newShoot.
  ///
  /// In tr, this message translates to:
  /// **'Yeni çekim'**
  String get newShoot;

  /// No description provided for @proActive.
  ///
  /// In tr, this message translates to:
  /// **'Shootly Pro aktif'**
  String get proActive;

  /// No description provided for @proTitle.
  ///
  /// In tr, this message translates to:
  /// **'Shootly Pro'**
  String get proTitle;

  /// No description provided for @perkUnlimited.
  ///
  /// In tr, this message translates to:
  /// **'Sınırsız günlük çekim'**
  String get perkUnlimited;

  /// No description provided for @perkSizes.
  ///
  /// In tr, this message translates to:
  /// **'Tüm pazaryeri ölçüleri ve özel ölçü'**
  String get perkSizes;

  /// No description provided for @perkBackdrops.
  ///
  /// In tr, this message translates to:
  /// **'Renkli zeminler ve zemin gölgesi'**
  String get perkBackdrops;

  /// No description provided for @perkBatch.
  ///
  /// In tr, this message translates to:
  /// **'Tek seferde {count} fotoğraf'**
  String perkBatch(int count);

  /// No description provided for @subscriptionTerms.
  ///
  /// In tr, this message translates to:
  /// **'Abonelik, dönem bitmeden en az 24 saat önce iptal edilmezse otomatik yenilenir. App Store hesap ayarlarından yönetebilir ve iptal edebilirsin.'**
  String get subscriptionTerms;

  /// No description provided for @groupAccount.
  ///
  /// In tr, this message translates to:
  /// **'HESAP'**
  String get groupAccount;

  /// No description provided for @restorePurchases.
  ///
  /// In tr, this message translates to:
  /// **'Satın alımları geri yükle'**
  String get restorePurchases;

  /// No description provided for @restoreSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Pro aboneliğin geri yüklendi.'**
  String get restoreSuccess;

  /// No description provided for @restoreNone.
  ///
  /// In tr, this message translates to:
  /// **'Geri yüklenecek bir abonelik bulunamadı.'**
  String get restoreNone;

  /// No description provided for @groupLegal.
  ///
  /// In tr, this message translates to:
  /// **'YASAL VE DESTEK'**
  String get groupLegal;

  /// No description provided for @privacyPolicy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik politikası'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In tr, this message translates to:
  /// **'Kullanım koşulları'**
  String get termsOfUse;

  /// No description provided for @support.
  ///
  /// In tr, this message translates to:
  /// **'Destek'**
  String get support;

  /// No description provided for @linkFailed.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı açılamadı.'**
  String get linkFailed;

  /// No description provided for @groupApp.
  ///
  /// In tr, this message translates to:
  /// **'UYGULAMA'**
  String get groupApp;

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @replayOnboarding.
  ///
  /// In tr, this message translates to:
  /// **'Tanıtımı tekrar göster'**
  String get replayOnboarding;

  /// No description provided for @version.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm'**
  String get version;

  /// No description provided for @privacyNote.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğrafların cihazında işlenir; hiçbir sunucuya gönderilmez.'**
  String get privacyNote;

  /// No description provided for @permCameraTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kamera izni kapalı'**
  String get permCameraTitle;

  /// No description provided for @permCameraBody.
  ///
  /// In tr, this message translates to:
  /// **'Ürün fotoğrafı çekebilmek için Shootly\'nin kameraya erişmesi gerekiyor. Fotoğraflar yalnızca cihazında işlenir, hiçbir yere gönderilmez.'**
  String get permCameraBody;

  /// No description provided for @permPhotosTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fotoğraflara erişim kapalı'**
  String get permPhotosTitle;

  /// No description provided for @permPhotosBody.
  ///
  /// In tr, this message translates to:
  /// **'Galeriden ürün fotoğrafı seçebilmek için fotoğraflarına erişim izni gerekiyor.'**
  String get permPhotosBody;

  /// No description provided for @permSaveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Galeriye kaydetme izni kapalı'**
  String get permSaveTitle;

  /// No description provided for @permSaveBody.
  ///
  /// In tr, this message translates to:
  /// **'Hazırlanan görselleri galerine kaydedebilmek için izin gerekiyor. İzin vermesen de görselleri \"Paylaş\" ile gönderebilirsin.'**
  String get permSaveBody;

  /// No description provided for @openSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarları aç'**
  String get openSettings;

  /// No description provided for @notNow.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi değil'**
  String get notNow;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
