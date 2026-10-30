/// Otomatik üretilmiş çeviri kodu (flutter gen-l10n); elle düzenlemeyin.
/// Metinler lib/l10n/app_tr.arb ve app_en.arb dosyalarındadır.
library;

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get proUpgrade => 'Go Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get retry => 'Try again';

  @override
  String get share => 'Share';

  @override
  String get close => 'Close';

  @override
  String get settings => 'Settings';

  @override
  String get homeHeadline => 'Shoot.\nShootly does\nthe rest.';

  @override
  String get homeSubtitle =>
      'The background is removed, your product sits on a clean white backdrop and is saved in marketplace-ready sizes.';

  @override
  String get shutterTapToShoot => 'Tap to shoot';

  @override
  String get shutterPickPhoto => 'Choose photo';

  @override
  String get pickFromGallery => 'Choose from library';

  @override
  String pickFromGalleryMax(int count) {
    return 'Choose from library (up to $count)';
  }

  @override
  String get photoPickFailed => 'Couldn\'t get the photo. Please try again.';

  @override
  String usageRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count free exports left today',
      one: '1 free export left today',
    );
    return '$_temp0';
  }

  @override
  String get usageExhausted =>
      'No free exports left today. They reset tomorrow.';

  @override
  String get usageUpgrade => 'Go unlimited';

  @override
  String get devModeNote =>
      'Development mode: \"Go Pro\" unlocks Pro without payment.';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Let\'s go';

  @override
  String get onboarding1Title => 'Shoot with one tap.';

  @override
  String get onboarding1Body =>
      'Take a photo of your product or pick one from your library. That\'s it.';

  @override
  String get onboarding2Title => 'Background gone in seconds.';

  @override
  String get onboarding2Body =>
      'On-device AI cuts out your product and places it on a clean white backdrop. No internet needed.';

  @override
  String get onboarding3Title => 'Marketplace-ready.';

  @override
  String get onboarding3Body =>
      'Sized for Trendyol, Hepsiburada, n11 and Amazon, named by barcode and saved to your library.';

  @override
  String get editorTitleSingle => 'Preview';

  @override
  String editorTitleMultiple(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count photos',
      one: '1 photo',
    );
    return '$_temp0';
  }

  @override
  String get barcodeHint => 'Barcode or product code (optional)';

  @override
  String get exportFailed => 'Couldn\'t prepare the images. Please try again.';

  @override
  String get buttonRemoving => 'Removing background…';

  @override
  String get buttonPreparing => 'Preparing…';

  @override
  String get buttonNoReady => 'No photos ready';

  @override
  String get buttonExport => 'Prepare & save';

  @override
  String buttonExportCount(int count) {
    return 'Prepare & save ($count)';
  }

  @override
  String get removalNoSubject =>
      'No product found in the photo. Center the product and try again.';

  @override
  String get removalFailed => 'Couldn\'t process the photo. Please try again.';

  @override
  String get sectionSize => 'SIZE';

  @override
  String get sectionBackdrop => 'BACKDROP';

  @override
  String get sizeOriginal => 'Original';

  @override
  String get sizeCustom => 'Custom';

  @override
  String get sizeMatchesProduct => 'Product ratio';

  @override
  String get floorShadow => 'Floor shadow';

  @override
  String get backdropWhite => 'White';

  @override
  String get backdropLightGrey => 'Light grey';

  @override
  String get backdropCream => 'Cream';

  @override
  String get backdropSky => 'Blue';

  @override
  String get backdropBlush => 'Pink';

  @override
  String get backdropBlack => 'Black';

  @override
  String get customSizeTitle => 'Custom size';

  @override
  String get customSizeSubtitle =>
      'Pick a preset ratio or enter your own size.';

  @override
  String get presetSquare => 'Square';

  @override
  String get presetVertical => 'Vertical';

  @override
  String get presetPortrait => 'Portrait';

  @override
  String get presetStory => 'Story';

  @override
  String get presetLandscape => 'Landscape';

  @override
  String get sizeWidth => 'Width';

  @override
  String get sizeHeight => 'Height';

  @override
  String customSizeRange(int min, int max) {
    return 'Each side must be between $min and $max pixels.';
  }

  @override
  String get apply => 'Apply';

  @override
  String get resultTitle => 'Done!';

  @override
  String resultSaved(int count, String album) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count images saved to the $album album.',
      one: '1 image saved to the $album album.',
    );
    return '$_temp0';
  }

  @override
  String resultDenied(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count images are ready. Saving to Photos needs permission, or you can send them with Share.',
      one:
          '1 image is ready. Saving to Photos needs permission, or you can send it with Share.',
    );
    return '$_temp0';
  }

  @override
  String resultFailed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count images are ready, but they couldn\'t be saved to Photos.',
      one: '1 image is ready, but it couldn\'t be saved to Photos.',
    );
    return '$_temp0';
  }

  @override
  String get grantAndSave => 'Allow & save';

  @override
  String get retrySave => 'Save again';

  @override
  String get newShoot => 'New shoot';

  @override
  String get proActive => 'Shootly Pro is active';

  @override
  String get proTitle => 'Shootly Pro';

  @override
  String get perkUnlimited => 'Unlimited daily exports';

  @override
  String get perkSizes => 'All marketplace sizes and custom size';

  @override
  String get perkBackdrops => 'Colored backdrops and floor shadow';

  @override
  String perkBatch(int count) {
    return 'Up to $count photos at once';
  }

  @override
  String get subscriptionTerms =>
      'Subscriptions renew automatically unless cancelled at least 24 hours before the end of the current period. Manage or cancel anytime in your App Store account settings.';

  @override
  String get groupAccount => 'ACCOUNT';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get restoreSuccess => 'Your Pro subscription has been restored.';

  @override
  String get restoreNone => 'No subscription found to restore.';

  @override
  String get groupLegal => 'LEGAL & SUPPORT';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsOfUse => 'Terms of use';

  @override
  String get support => 'Support';

  @override
  String get linkFailed => 'Couldn\'t open the link.';

  @override
  String get groupApp => 'APP';

  @override
  String get language => 'Language';

  @override
  String get replayOnboarding => 'Show the intro again';

  @override
  String get version => 'Version';

  @override
  String get privacyNote =>
      'Your photos are processed on your device and never uploaded.';

  @override
  String get permCameraTitle => 'Camera access is off';

  @override
  String get permCameraBody =>
      'Shootly needs camera access to take product photos. Photos are processed only on your device and never uploaded.';

  @override
  String get permPhotosTitle => 'Photo access is off';

  @override
  String get permPhotosBody =>
      'Shootly needs access to your photos so you can pick product photos from your library.';

  @override
  String get permSaveTitle => 'Saving to Photos is off';

  @override
  String get permSaveBody =>
      'Shootly needs permission to save the finished images to your Photos. You can still send them with Share.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get notNow => 'Not now';
}
