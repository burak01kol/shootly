/// Ayarlar ekranı: Pro abonelik durumu, satın alımları geri yükleme, gizlilik
/// politikası / kullanım koşulları / destek bağlantıları, tanıtımı yeniden gösterme ve sürüm.
library;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../core/config/app_config.dart';
import '../../core/di/app_services.dart';
import '../onboarding/onboarding_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _proPerks = [
    'Sınırsız günlük çekim',
    'Tüm pazaryeri ölçüleri ve özel ölçü',
    'Renkli zeminler ve zemin gölgesi',
    'Tek seferde ${AppConfig.maxPhotosPerProduct} fotoğraf',
  ];

  Future<void> _restore(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final restored = await ServicesScope.of(context).subscription.restore();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          restored
              ? 'Pro aboneliğin geri yüklendi.'
              : 'Geri yüklenecek bir abonelik bulunamadı.',
        ),
      ),
    );
  }

  Future<void> _openLink(BuildContext context, String url) async {
    final messenger = ScaffoldMessenger.of(context);
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Bağlantı açılamadı.')),
      );
    }
  }

  Future<void> _replayOnboarding(BuildContext context) async {
    final navigator = Navigator.of(context);
    await ServicesScope.of(context).preferences.resetOnboarding();
    await navigator.pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const OnboardingPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final subscription = ServicesScope.of(context).subscription;
    return ListenableBuilder(
      listenable: subscription,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Ayarlar')),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _ProCard(
              isPro: subscription.isPro,
              perks: _proPerks,
              onUpgrade: subscription.showPaywall,
            ),
            const SizedBox(height: 24),
            const _GroupTitle('HESAP'),
            _SettingsTile(
              icon: Icons.restore_rounded,
              title: 'Satın alımları geri yükle',
              onTap: () => _restore(context),
            ),
            const SizedBox(height: 24),
            const _GroupTitle('YASAL VE DESTEK'),
            _SettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Gizlilik politikası',
              onTap: () => _openLink(context, AppConfig.privacyPolicyUrl),
            ),
            _SettingsTile(
              icon: Icons.description_outlined,
              title: 'Kullanım koşulları',
              onTap: () => _openLink(context, AppConfig.termsOfUseUrl),
            ),
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              title: 'Destek',
              onTap: () => _openLink(context, AppConfig.supportUrl),
            ),
            const SizedBox(height: 24),
            const _GroupTitle('UYGULAMA'),
            _SettingsTile(
              icon: Icons.slideshow_rounded,
              title: 'Tanıtımı tekrar göster',
              onTap: () => _replayOnboarding(context),
            ),
            const _SettingsTile(
              icon: Icons.info_outline_rounded,
              title: 'Sürüm',
              trailing: AppConfig.appVersion,
            ),
            const SizedBox(height: 28),
            const Row(
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 18,
                  color: ShootlyColors.muted,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Fotoğrafların cihazında işlenir; hiçbir sunucuya gönderilmez.',
                    style: TextStyle(color: ShootlyColors.muted, height: 1.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProCard extends StatelessWidget {
  const _ProCard({
    required this.isPro,
    required this.perks,
    required this.onUpgrade,
  });

  final bool isPro;
  final List<String> perks;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    const onInk = TextStyle(color: Colors.white);
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: ShootlyColors.ink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPro ? 'Shootly Pro aktif' : 'Shootly Pro',
            style: onInk.copyWith(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          for (final perk in perks)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_rounded, size: 18, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      perk,
                      style: onInk.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          if (!isPro) ...[
            const SizedBox(height: 10),
            FilledButton(
              onPressed: onUpgrade,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ShootlyColors.ink,
              ),
              child: const Text("Pro'ya geç"),
            ),
            const SizedBox(height: 12),
            Text(
              'Abonelik, dönem bitmeden en az 24 saat önce iptal edilmezse '
              'otomatik yenilenir. App Store hesap ayarlarından yönetebilir '
              've iptal edebilirsin.',
              style: onInk.copyWith(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  /// [text] Türkçe büyük harf kuralı için hazır büyük harfle verilir.
  const _GroupTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: ShootlyColors.muted,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: ShootlyColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Icon(icon, color: ShootlyColors.ink),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: trailing != null
              ? Text(
                  trailing!,
                  style: const TextStyle(
                    color: ShootlyColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : onTap != null
                  ? const Icon(Icons.chevron_right_rounded)
                  : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
