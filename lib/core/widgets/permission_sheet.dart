/// İzin reddedildiğinde gösterilen açıklama penceresi.
/// Neden gerektiğini sade bir dille anlatır ve tek dokunuşla uygulamanın sistem ayarlarını açar.
library;

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Uygulamanın kullandığı izinler.
enum AppPermission {
  camera(
    icon: Icons.photo_camera_outlined,
    title: 'Kamera izni kapalı',
    message: 'Ürün fotoğrafı çekebilmek için Shootly\'nin kameraya erişmesi '
        'gerekiyor. Fotoğraflar yalnızca cihazında işlenir, hiçbir yere '
        'gönderilmez.',
  ),
  photos(
    icon: Icons.photo_library_outlined,
    title: 'Fotoğraflara erişim kapalı',
    message: 'Galeriden ürün fotoğrafı seçebilmek için fotoğraflarına erişim '
        'izni gerekiyor.',
  ),
  saveToGallery(
    icon: Icons.download_outlined,
    title: 'Galeriye kaydetme izni kapalı',
    message: 'Hazırlanan görselleri galerine kaydedebilmek için izin '
        'gerekiyor. İzin vermesen de görselleri "Paylaş" ile '
        'gönderebilirsin.',
  );

  const AppPermission({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;
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
              permission.title,
              style: Theme.of(sheetContext).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              permission.message,
              style: const TextStyle(color: ShootlyColors.muted, height: 1.45),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                Navigator.of(sheetContext).pop();
                AppSettings.openAppSettings();
              },
              child: const Text('Ayarları aç'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(sheetContext).pop(),
              child: const Text(
                'Şimdi değil',
                style: TextStyle(color: ShootlyColors.muted),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
