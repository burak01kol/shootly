/// Kök `MaterialApp` widget'ı.
/// Shootly temasını ve Türkçe dilini uygular; ilk açılışta onboarding mi ana sayfa mı gösterileceğini belirler.
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/config/app_config.dart';
import '../core/di/app_services.dart';
import '../features/home/home_page.dart';
import '../features/onboarding/onboarding_page.dart';
import 'theme.dart';

class ShootlyApp extends StatelessWidget {
  const ShootlyApp({super.key, required this.services});

  final AppServices services;

  @override
  Widget build(BuildContext context) {
    return ServicesScope(
      services: services,
      child: MaterialApp(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        themeMode: ThemeMode.light,
        // Uygulama yalnızca Türkçe; menüler ve sistem metinleri de Türkçe görünür.
        locale: const Locale('tr'),
        supportedLocales: const [Locale('tr')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        home: services.preferences.onboardingSeen
            ? const HomePage()
            : const OnboardingPage(),
      ),
    );
  }
}
