/// Pro abonelik durumunu yöneten servisler.
/// RevenueCat ile çalışan gerçek servis ve anahtar verilmediğinde kullanılan geliştirme modu servisi.
library;

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import '../config/app_config.dart';

/// Pro abonelik durumu. Değişince dinleyicilere haber verir.
abstract class SubscriptionService extends ChangeNotifier {
  bool get isPro;

  /// Gerçek ödeme altyapısı bağlı mı? (Geliştirme modunda false.)
  bool get isConfigured;

  Future<void> init();

  /// Paywall'u gösterir. İşlem sonunda kullanıcı Pro ise true döner.
  Future<bool> showPaywall();

  Future<bool> restore();
}

/// RevenueCat ile çalışan gerçek abonelik servisi.
/// Paywall tasarımı RevenueCat panelinden, kod değiştirmeden yönetilir.
class RevenueCatSubscriptionService extends SubscriptionService {
  RevenueCatSubscriptionService(this._apiKey);

  final String _apiKey;
  bool _isPro = false;

  @override
  bool get isPro => _isPro;

  @override
  bool get isConfigured => true;

  @override
  Future<void> init() async {
    try {
      await Purchases.configure(PurchasesConfiguration(_apiKey));
      Purchases.addCustomerInfoUpdateListener(_apply);
      _apply(await Purchases.getCustomerInfo());
    } catch (error) {
      debugPrint('RevenueCat başlatılamadı: $error');
    }
  }

  @override
  Future<bool> showPaywall() async {
    try {
      await RevenueCatUI.presentPaywallIfNeeded(AppConfig.proEntitlementId);
      _apply(await Purchases.getCustomerInfo());
    } catch (error) {
      debugPrint('Paywall açılamadı: $error');
    }
    return _isPro;
  }

  @override
  Future<bool> restore() async {
    try {
      _apply(await Purchases.restorePurchases());
    } catch (error) {
      debugPrint('Geri yükleme başarısız: $error');
    }
    return _isPro;
  }

  void _apply(CustomerInfo info) {
    final active =
        info.entitlements.active.containsKey(AppConfig.proEntitlementId);
    if (active == _isPro) return;
    _isPro = active;
    notifyListeners();
  }
}

/// RevenueCat anahtarı verilmediğinde kullanılır: paywall yerine Pro'yu
/// doğrudan açar. Böylece geliştirirken Pro özellikleri denenebilir.
class DevSubscriptionService extends SubscriptionService {
  bool _isPro = false;

  @override
  bool get isPro => _isPro;

  @override
  bool get isConfigured => false;

  @override
  Future<void> init() async {}

  @override
  Future<bool> showPaywall() async {
    _isPro = true;
    notifyListeners();
    return true;
  }

  @override
  Future<bool> restore() async => _isPro;
}
