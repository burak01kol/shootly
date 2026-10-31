# Shootly

Pazaryeri satıcıları için ürün fotoğrafı uygulaması. Satıcı ürünü çeker, arka plan
**cihazda** silinir (internet ve sunucu maliyeti yok), ürün beyaz zemine oturtulur ve
Trendyol, Hepsiburada, n11, Amazon, Etsy ölçülerinde `barkod_1.jpg`, `barkod_2.jpg`…
olarak kaydedilir.

## Kurulum (Windows)

1. Flutter ve Android Studio kurulu olmalı (`flutter doctor` yeşil).
2. Bu klasörde **`kurulum.bat`** dosyasına çift tıkla. Yaptıkları:
   - `flutter create` ile `android/` ve `ios/` klasörlerini oluşturur (mevcut kodlara dokunmaz)
   - paketleri `flutter pub add` ile güncel uyumlu sürümlerde ekler
   - `tool/platform_ayarla.ps1` ile Android/iOS ayarlarını yapar
   - `flutter analyze` ve `flutter test` çalıştırır
3. Telefonu USB ile bağla ve `flutter run`.

> Arka plan silme **gerçek cihazda** çalışır. Android'de Google Play Hizmetleri
> gerekir; iOS'ta iOS 17+ ve gerçek cihaz gerekir (simülatör desteklemez).

## Abonelik (RevenueCat)

Anahtar verilmezse uygulama **geliştirme modunda** açılır: "Pro'ya geç" ödeme almadan
Pro'yu açar, böylece tüm özellikler denenebilir.

Gerçek ödeme için:
1. [app.revenuecat.com](https://app.revenuecat.com) → proje oluştur, Google Play uygulamasını bağla.
2. Ürünler: `shootly_pro_monthly` (aylık ₺129,99) ve `shootly_pro_yearly` (yıllık ₺699,99, 3 gün ücretsiz deneme). Entitlement kimliği: **`pro`**.
   Fiyatların gerekçesi ve App Store adımları: `belgeler/APP_STORE_YAYIN_REHBERI.md`.
3. Paywalls bölümünden paywall tasarla ve **yayınla**.
4. Çalıştır: `flutter run --dart-define=RC_ANDROID_KEY=goog_xxxxx`

## Mimari

```
lib/
├─ main.dart                  Giriş noktası
├─ app/                       MaterialApp, tema
├─ core/
│  ├─ config/app_config.dart  Sabitler (limitler, anahtarlar)
│  ├─ di/app_services.dart    Servislerin oluşturulması + ServicesScope
│  ├─ models/                 Marketplace, Backdrop, ExportSettings, Cutout
│  ├─ services/               İş mantığı (UI'dan bağımsız)
│  │  ├─ background_remover   Cihaz üstü arka plan silme (native_cutout)
│  │  ├─ image_composer       Tuval + ortalama + gölge + JPG (saf Dart, test edilir)
│  │  ├─ export_service       Dosya üretme, galeri, paylaşım
│  │  ├─ subscription_service RevenueCat / geliştirme modu
│  │  └─ usage_limiter        Ücretsiz planda günlük 3 hak
│  └─ widgets/                Ortak widget'lar
└─ features/                  Ekranlar (her özellik kendi klasöründe)
   ├─ onboarding/  home/  editor/  export/
```

**Kurallar**
- Ekranlar servislere `ServicesScope.of(context)` ile ulaşır; servisler Flutter
  widget'ı bilmez.
- Ekran durumu `ChangeNotifier` (ör. `EditorController`) + `ListenableBuilder`.
- Servisler arayüz arkasında (`BackgroundRemover`, `SubscriptionService`); test veya
  sağlayıcı değişikliği için sahtesi yazılabilir.
- Pro kontrolü tek yerde: `ExportSettings.needsPro` ve `Marketplace/Backdrop.isFree`.
- Pazaryeri ölçüleri `core/models/marketplace.dart` içinde; yayından önce satıcı
  panellerinden doğrulayın.

## Ücretsiz / Pro

| | Ücretsiz | Pro |
|---|---|---|
| Dışa aktarma | Günde 3 | Sınırsız |
| Fotoğraf / ürün | 1 | 8 (toplu) |
| Pazaryeri | Trendyol | Tümü |
| Arka plan | Beyaz | 6 renk |
| Zemin gölgesi | — | ✓ |

## Yol haritası (sıradaki işler)

- [ ] Son projeler listesi (ana ekranda)
- [ ] Elle düzeltme fırçası (silinen/kalan alanları düzeltme)
- [ ] Bulanık fotoğraf uyarısı
- [ ] Türkçe/İngilizce çeviri (`flutter gen-l10n`, metinler şu an kodda)
- [ ] AI sahne üretimi (kredi paketiyle, sunucu maliyetini kendisi karşılar)
- [ ] Gizlilik politikası sayfası (GitHub Pages) — mağaza için zorunlu

## Google Play'e çıkış

1. `flutter build appbundle` (imzalama: Flutter belgelerindeki "Build and release an Android app").
2. Yeni kişisel hesaplarda **12 testçi ile 14 gün kapalı test** zorunlu.
3. Mağaza başlığında anahtar kelime: "Ürün Fotoğrafı – Trendyol Arka Plan Silme".
