/// Ana sayfa: tek büyük deklanşör butonuyla yeni ürün çekimi başlatır.
/// Kamerası olmayan cihazlarda aynı buton fotoğraf seçer; kalan ücretsiz hak, Pro durumu ve ayarlara geçiş de burada.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/theme.dart';
import '../../core/config/app_config.dart';
import '../../core/di/app_services.dart';
import '../../core/widgets/permission_sheet.dart';
import '../../core/widgets/shootly_wordmark.dart';
import '../editor/editor_page.dart';
import '../settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final _picker = ImagePicker();
  static const _maxSide = 3000.0;
  static const _quality = 95;

  /// Kamera yalnızca telefonlarda var; masaüstünde deklanşör galeriyi açar.
  static bool get _hasCamera =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Widget build(BuildContext context) {
    final services = ServicesScope.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([services.subscription, services.usage]),
      builder: (context, _) {
        final subscription = services.subscription;
        final isPro = subscription.isPro;
        final theme = Theme.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopBar(
                    isPro: isPro,
                    onUpgrade: subscription.showPaywall,
                    onSettings: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const SettingsPage(),
                      ),
                    ),
                  ),
                  if (!subscription.isConfigured) ...[
                    const SizedBox(height: 16),
                    const _DevModeNote(),
                  ],
                  const Spacer(),
                  Text(
                    'Çek.\nGerisini Shootly\nhalleder.',
                    style: theme.textTheme.displaySmall?.copyWith(height: 1.08),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Arka plan silinir, ürün beyaz zemine oturur ve '
                    'pazaryeri ölçüsünde kaydedilir.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: ShootlyColors.muted,
                      height: 1.45,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Center(
                    child: _ShutterButton(
                      icon: _hasCamera
                          ? Icons.photo_camera_rounded
                          : Icons.add_photo_alternate_rounded,
                      label: _hasCamera ? 'Dokun ve çek' : 'Fotoğraf seç',
                      onTap: () => _hasCamera
                          ? _pickFromCamera(context)
                          : _pickFromGallery(context, multiple: isPro),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_hasCamera)
                    Center(
                      child: TextButton.icon(
                        onPressed: () =>
                            _pickFromGallery(context, multiple: isPro),
                        icon: const Icon(Icons.photo_library_outlined, size: 20),
                        label: Text(
                          isPro
                              ? 'Galeriden seç (en fazla ${AppConfig.maxPhotosPerProduct})'
                              : 'Galeriden seç',
                        ),
                      ),
                    ),
                  const Spacer(),
                  if (!isPro)
                    _UsagePill(
                      remaining: services.usage.remainingToday,
                      onUpgrade: subscription.showPaywall,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickFromCamera(BuildContext context) async {
    final file = await _withPermission(
      context,
      AppPermission.camera,
      () => _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: _maxSide,
        maxHeight: _maxSide,
        imageQuality: _quality,
      ),
    );
    if (file == null || !context.mounted) return;
    await _openEditor(context, [file.path]);
  }

  Future<void> _pickFromGallery(
    BuildContext context, {
    required bool multiple,
  }) async {
    final files = await _withPermission(context, AppPermission.photos, () async {
      if (multiple) {
        return _picker.pickMultiImage(
          maxWidth: _maxSide,
          maxHeight: _maxSide,
          imageQuality: _quality,
        );
      }
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: _maxSide,
        maxHeight: _maxSide,
        imageQuality: _quality,
      );
      return [if (file != null) file];
    });
    if (files == null || files.isEmpty || !context.mounted) return;
    final paths = files
        .take(AppConfig.maxPhotosPerProduct)
        .map((file) => file.path)
        .toList();
    await _openEditor(context, paths);
  }

  /// Seçiciyi çalıştırır; izin reddedilmişse açıklama penceresini gösterir,
  /// başka bir hata olursa kısa bir mesaj verir. Her iki durumda null döner.
  Future<T?> _withPermission<T>(
    BuildContext context,
    AppPermission permission,
    Future<T> Function() pick,
  ) async {
    try {
      return await pick();
    } on PlatformException catch (error) {
      if (!context.mounted) return null;
      if (error.code.endsWith('access_denied')) {
        await showPermissionSheet(context, permission);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fotoğraf alınamadı. Tekrar dene.')),
        );
      }
      return null;
    }
  }

  Future<void> _openEditor(BuildContext context, List<String> paths) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => EditorPage(sourcePaths: paths)),
    );
  }

}

/// Logo, Pro durumu ve ayarlar.
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.isPro,
    required this.onUpgrade,
    required this.onSettings,
  });

  final bool isPro;
  final VoidCallback onUpgrade;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShootlyWordmark(),
        const Spacer(),
        if (isPro)
          const _Pill(
            label: 'PRO',
            background: ShootlyColors.ink,
            foreground: Colors.white,
          )
        else
          _Pill(
            label: "Pro'ya geç",
            icon: Icons.bolt_rounded,
            background: ShootlyColors.surface,
            foreground: ShootlyColors.ink,
            onTap: onUpgrade,
          ),
        const SizedBox(width: 4),
        IconButton(
          tooltip: 'Ayarlar',
          onPressed: onSettings,
          icon: const Icon(Icons.tune_rounded),
        ),
      ],
    );
  }
}

/// Uygulamanın tek ana eylemi: büyük, yuvarlak deklanşör.
class _ShutterButton extends StatelessWidget {
  const _ShutterButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  static const _size = 118.0;

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          label: label,
          child: Container(
            width: _size,
            height: _size,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ShootlyColors.ink, width: 3),
            ),
            child: Material(
              color: ShootlyColors.ink,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: Icon(icon, size: 40, color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: foreground),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ücretsiz planda kalan günlük hak.
class _UsagePill extends StatelessWidget {
  const _UsagePill({required this.remaining, required this.onUpgrade});

  final int remaining;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final message = remaining > 0
        ? 'Bugün $remaining ücretsiz hakkın var'
        : 'Bugünkü hakların bitti, yarın yenilenir';
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 6, 6, 6),
      decoration: BoxDecoration(
        color: ShootlyColors.surface,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: ShootlyColors.muted,
              ),
            ),
          ),
          TextButton(onPressed: onUpgrade, child: const Text('Sınırsız yap')),
        ],
      ),
    );
  }
}

class _DevModeNote extends StatelessWidget {
  const _DevModeNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: ShootlyColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        "Geliştirme modu: \"Pro'ya geç\" ödeme almadan Pro'yu açar.",
        style: TextStyle(
          color: ShootlyColors.muted,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
