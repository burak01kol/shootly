/// Kök `MaterialApp` widget'ı.
/// Shootly temasını ve seçili dili (varsayılan Türkçe) uygular; ilk açılışta onboarding mi ana sayfa mı gösterileceğini belirler.
library;

import 'package:flutter/material.dart';

import '../core/config/app_config.dart';
import '../core/di/app_services.dart';
import '../features/home/home_page.dart';
import '../features/onboarding/onboarding_page.dart';
import 'l10n.dart';
import 'theme.dart';

class ShootlyApp extends StatelessWidget {
  const ShootlyApp({super.key, required this.services});

  final AppServices services;

  @override
  Widget build(BuildContext context) {
    return ServicesScope(
      services: services,
      child: ListenableBuilder(
        listenable: services.language,
        builder: (context, _) => MaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          themeMode: ThemeMode.light,
          locale: services.language.language.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: services.preferences.onboardingSeen
              ? const HomePage()
              : const OnboardingPage(),
        ),
      ),
    );
  }
}
