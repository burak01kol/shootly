/// İlk açılışta gösterilen üç adımlı tanıtım: çek, arka plan silinsin, pazaryerine hazır.
/// Bitince tercih kaydedilir ve kullanıcı ana sayfaya yönlendirilir.
library;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/di/app_services.dart';
import '../../core/widgets/shootly_wordmark.dart';
import '../home/home_page.dart';
import '../../app/l10n.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _slideCount = 3;

  static List<_Slide> _slidesFor(AppLocalizations l10n) => [
        _Slide(
          icon: Icons.photo_camera_rounded,
          step: '01',
          title: l10n.onboarding1Title,
          body: l10n.onboarding1Body,
        ),
        _Slide(
          icon: Icons.auto_awesome_rounded,
          step: '02',
          title: l10n.onboarding2Title,
          body: l10n.onboarding2Body,
        ),
        _Slide(
          icon: Icons.storefront_rounded,
          step: '03',
          title: l10n.onboarding3Title,
          body: l10n.onboarding3Body,
        ),
      ];

  final _pageController = PageController();
  int _index = 0;

  bool get _isLast => _index == _slideCount - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _finish() async {
    final services = ServicesScope.of(context);
    await services.preferences.markOnboardingSeen();
    final subscription = services.subscription;
    if (subscription.isConfigured && !subscription.isPro) {
      await subscription.showPaywall();
    }
    if (!mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const ShootlyWordmark(),
                  const Spacer(),
                  if (!_isLast)
                    TextButton(
                      onPressed: _finish,
                      child: Text(
                        context.l10n.onboardingSkip,
                        style: const TextStyle(color: ShootlyColors.muted),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _index = index),
                  children: [
                    for (final slide in _slidesFor(context.l10n))
                      _SlideView(slide),
                  ],
                ),
              ),
              _PageDots(count: _slideCount, index: _index),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isLast ? _finish : _next,
                child: Text(
                  _isLast
                      ? context.l10n.onboardingStart
                      : context.l10n.onboardingNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slide {
  const _Slide({
    required this.icon,
    required this.step,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String step;
  final String title;
  final String body;
}

class _SlideView extends StatelessWidget {
  const _SlideView(this.slide);

  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: ShootlyColors.surface,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(slide.icon, size: 44, color: ShootlyColors.ink),
        ),
        const SizedBox(height: 36),
        Text(
          slide.step,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: ShootlyColors.muted,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          slide.title,
          style: theme.textTheme.displaySmall?.copyWith(height: 1.1),
        ),
        const SizedBox(height: 14),
        Text(
          slide.body,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: ShootlyColors.muted,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.only(right: 6),
            width: i == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index ? ShootlyColors.ink : ShootlyColors.line,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
