/// İzin reddedildiğinde gösterilen açıklama penceresi.
/// Neden gerektiğini sade bir dille anlatır ve tek dokunuşla uygulamanın sistem ayarlarını açar.
library;

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../app/l10n.dart';

/// Uygulamanın kullandığı izinler.
enum AppPermission {
  camera(Icons.photo_camera_outlined),
  photos(Icons.photo_library_outlined),
  saveToGallery(Icons.download_outlined);

  const AppPermission(this.icon);

  final IconData icon;

  String title(AppLocalizations l10n) => switch (this) {
        AppPermission.camera => l10n.permCameraTitle,
        AppPermission.photos => l10n.permPhotosTitle,
        AppPermission.saveToGallery => l10n.permSaveTitle,
      };

  String message(AppLocalizations l10n) => switch (this) {
        AppPermission.camera => l10n.permCameraBody,
        AppPermission.photos => l10n.permPhotosBody,
        AppPermission.saveToGallery => l10n.permSaveBody,
      };
}

/// Pencereyi açar; kullanıcı "Ayarları aç" derse sistem ayarlarına gider.
Future<void> showPermissionSheet(
  BuildContext context,
  AppPermission permission,
) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    backgroundColor: ShootlyColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ShootlyColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(permission.icon, color: ShootlyColors.ink, size: 28),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              permission.title(sheetContext.l10n),
              style: Theme.of(sheetContext).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              permission.message(sheetContext.l10n),
              style: const TextStyle(color: ShootlyColors.muted, height: 1.45),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                Navigator.of(sheetContext).pop();
                AppSettings.openAppSettings();
              },
              child: Text(sheetContext.l10n.openSettings),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(sheetContext).pop(),
              child: Text(
                sheetContext.l10n.notNow,
                style: const TextStyle(color: ShootlyColors.muted),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
