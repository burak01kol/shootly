/// Servislerin oluşturulması ve widget ağacına dağıtılması.
/// [AppServices] tüm servisleri bir arada tutar; ekranlar onlara `ServicesScope.of(context)` ile ulaşır.
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../services/app_preferences.dart';
import '../services/background_remover.dart';
import '../services/export_service.dart';
import '../services/image_composer.dart';
import '../services/subscription_service.dart';
import '../services/usage_limiter.dart';

/// Uygulamanın tüm servisleri tek yerde. Testte sahteleri verilebilir.
class AppServices {
  const AppServices({
    required this.preferences,
    required this.subscription,
    required this.usage,
    required this.remover,
    required this.exporter,
  });

  final AppPreferences preferences;
  final SubscriptionService subscription;
  final UsageLimiter usage;
  final BackgroundRemover remover;
  final ExportService exporter;

  static Future<AppServices> create() async {
    final prefs = await SharedPreferences.getInstance();
    final subscription = _createSubscription();
    await subscription.init();

    const remover = NativeBackgroundRemover();
    unawaited(
      remover.warmUp().catchError(
            (Object error) => debugPrint('Model hazırlanamadı: $error'),
          ),
    );

    return AppServices(
      preferences: AppPreferences(prefs),
      subscription: subscription,
      usage: UsageLimiter(prefs),
      remover: remover,
      exporter: const ExportService(ImageComposer()),
    );
  }

  static SubscriptionService _createSubscription() {
    final key = Platform.isIOS
        ? AppConfig.revenueCatIosKey
        : AppConfig.revenueCatAndroidKey;
    return key.isEmpty
        ? DevSubscriptionService()
        : RevenueCatSubscriptionService(key);
  }
}

/// Servisleri widget ağacına verir: `ServicesScope.of(context)`.
class ServicesScope extends InheritedWidget {
  const ServicesScope({
    super.key,
    required this.services,
    required super.child,
  });

  final AppServices services;

  static AppServices of(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<ServicesScope>();
    assert(scope != null, 'ServicesScope widget ağacında bulunamadı.');
    return scope!.services;
  }

  @override
  bool updateShouldNotify(ServicesScope oldWidget) =>
      services != oldWidget.services;
}
