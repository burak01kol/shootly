/// Çeviri metinlerine kısa erişim: `context.l10n.anahtar`.
/// Üretilmiş [AppLocalizations] sınıfını da dışa açar; ekranlar yalnızca bu dosyayı içe aktarır.
library;

import 'package:flutter/widgets.dart';

import '../l10n/app_localizations.dart';

export '../l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
