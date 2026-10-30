/// Ayarlar'daki dil seçim penceresi (Türkçe / English).
/// Seçim hemen uygulanır ve kalıcı olarak saklanır; diller kendi adlarıyla listelenir.
library;

import 'package:flutter/material.dart';

import '../../../app/l10n.dart';
import '../../../app/theme.dart';
import '../../../core/di/app_services.dart';
import '../../../core/services/language_controller.dart';

Future<void> showLanguageSheet(BuildContext context) {
  final controller = ServicesScope.of(context).language;
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    backgroundColor: ShootlyColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                sheetContext.l10n.language,
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
            ),
            for (final language in AppLanguage.values)
              _LanguageOption(
                language: language,
                selected: language == controller.language,
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  controller.select(language);
                },
              ),
          ],
        ),
      ),
    ),
  );
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? ShootlyColors.ink : ShootlyColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: onTap,
          title: Text(
            language.nativeName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : ShootlyColors.ink,
            ),
          ),
          trailing: selected
              ? const Icon(Icons.check_rounded, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
