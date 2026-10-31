# Shootly — Proje Belgesi

> Pazaryeri satıcıları için **tek dokunuşla ürün fotoğrafı** hazırlayan Flutter uygulaması.
> Bu belge projenin tamamını anlatır: ne yaptığı, nasıl kurulduğu, hangi hesaplara bağlı olduğu,
> kodun nerede ne yaptığı, nasıl yayınlandığı ve bundan sonra ne yapılacağı.
>
> Son güncelleme: **31 Ekim 2026** · Sürüm **1.0.0** · Durum: **App Store incelemesinde (Waiting for Review)**

---

## İçindekiler
1. [Kısa özet](#1-kısa-özet)
2. [Durum ve zaman çizelgesi](#2-durum-ve-zaman-çizelgesi)
3. [Klasör yapısı](#3-klasör-yapısı)
4. [Bağlantılar ve hesaplar](#4-bağlantılar-ve-hesaplar)
5. [Özellikler (ayrıntılı)](#5-özellikler-ayrıntılı)
6. [Ücretsiz ve Pro](#6-ücretsiz-ve-pro)
7. [Ekranlar](#7-ekranlar)
8. [Tasarım sistemi](#8-tasarım-sistemi)
9. [Mimari ve kod haritası](#9-mimari-ve-kod-haritası)
10. [Veri akışı: bir fotoğrafın yolculuğu](#10-veri-akışı-bir-fotoğrafın-yolculuğu)
11. [Dil desteği](#11-dil-desteği)
12. [Ödeme ve abonelik altyapısı](#12-ödeme-ve-abonelik-altyapısı)
13. [Gizlilik, izinler ve veri](#13-gizlilik-izinler-ve-veri)
14. [Platform ayarları (iOS / Android / Windows)](#14-platform-ayarları)
15. [Derleme ve yayın (Codemagic)](#15-derleme-ve-yayın-codemagic)
16. [App Store kaydı ve mağaza bilgileri](#16-app-store-kaydı-ve-mağaza-bilgileri)
17. [Testler ve kalite](#17-testler-ve-kalite)
18. [Geliştirme ortamı ve komutlar](#18-geliştirme-ortamı-ve-komutlar)
19. [Proje kuralları](#19-proje-kuralları)
20. [Karşılaşılan sorunlar ve çözümleri](#20-karşılaşılan-sorunlar-ve-çözümleri)
21. [Yol haritası](#21-yol-haritası)

---

## 1. Kısa özet

| | |
|---|---|
| **Ad** | Shootly |
| **Ne yapar** | Ürün fotoğrafının arka planını **cihazda** siler, ürünü beyaz (ya da seçilen) zemine ortalar, pazaryeri ölçüsünde barkodla adlandırılmış JPG olarak galeriye kaydeder |
| **Kime** | Trendyol, Hepsiburada, n11, Amazon, Etsy ve Instagram'da satış yapan satıcılara |
| **Fark** | Tek tuş akışı · fotoğraflar hiçbir sunucuya gitmez · internet gerekmez · Türk pazaryeri ölçüleri hazır |
| **Gelir modeli** | Ücretsiz indirme + Shootly Pro aboneliği (aylık ₺149,99 / yıllık, 3 gün ücretsiz deneme) |
| **Teknoloji** | Flutter 3.47 / Dart 3.13 · iOS 17+ (Apple Vision) · Android (ML Kit, sonraki aşama) |
| **Diller** | Türkçe (varsayılan) · İngilizce |
| **Kod** | `C:\Users\burak\source\vitrin` · GitHub: `burak01kol/shootly` (herkese açık) |
| **Gizli anahtarlar** | `C:\Users\burak\source\Shootly_Gizli_Anahtarlar` (**proje dışında**, GitHub'a gitmez) |

Proje ilk olarak **"Vitrin"** adıyla kuruldu, 29 Ekim 2026'da **Shootly** adını aldı. Dart paket adı hâlâ `vitrin` (iç ad, kullanıcıya görünmez).

---

## 2. Durum ve zaman çizelgesi

| Tarih | Olay |
|---|---|
| 29.10.2026 | Proje kuruldu (`kurulum.bat`), Android SDK/NDK tamamlandı, Windows masaüstü desteği eklendi |
| 29.10.2026 | Ad **Shootly** oldu; beyaz + siyah tek tuş arayüz, Plus Jakarta Sans fontu |
| 29.10.2026 | Orijinal ve özel ölçü, son ayarları hatırlama, Ayarlar ekranı eklendi |
| 29.10.2026 | App Store hazırlığı: iOS 17, iPhone, dikey, izin pencereleri, gizlilik/koşul bağlantıları, Codemagic, GitHub Pages |
| 30.10.2026 | Türk pazarı fiyat araştırması; TR/EN dil seçeneği; Apple paket kimliği ve App Store Connect kaydı |
| 30.10.2026 | Codemagic imza sertifikası + profil; ilk TestFlight derlemeleri (0.1.0) |
| 30.10.2026 | Kamera + S ikonu; sürüm 1.0.0 |
| 31.10.2026 | Abonelikler (aylık/yıllık), RevenueCat (ürünler, `pro` yetkisi, offering, paywall) |
| 31.10.2026 | App Store derlemesi 1.0.0 (3); mağaza sayfası, gizlilik formu, Türkiye'de yayın ayarı |
| **31.10.2026** | **İncelemeye gönderildi** — "4 Items Submitted" (uygulama + abonelik grubu + 2 abonelik) |

**Bekleyenler:** Apple incelemesi (≤48 saat) · Paid Apps sözleşmesinin (banka/vergi) onayı.

---

## 3. Klasör yapısı

```
C:\Users\burak\source\vitrin\                  ← PROJE (GitHub: burak01kol/shootly, Public)
├─ SHOOTLY_PROJE_BELGESI.md                    ← bu belge
├─ README.md                                    kısa tanıtım + kurulum
├─ belgeler\
│  └─ APP_STORE_YAYIN_REHBERI.md                App Store'a yayın adımları, metinler, kontrol listesi
├─ lib\                                         uygulama kodu (bkz. bölüm 9)
│  ├─ app\                                      kök widget, tema, çeviri erişimi
│  ├─ core\                                     modeller, servisler, ortak widget'lar
│  ├─ features\                                 ekranlar (onboarding, home, editor, export, settings)
│  ├─ l10n\                                     çeviri dosyaları (app_tr.arb, app_en.arb) + üretilen kod
│  └─ main.dart
├─ test\                                        birim ve widget testleri (26 test)
├─ assets\
│  ├─ fonts\                                    Plus Jakarta Sans (5 ağırlık, gömülü)
│  └─ icon\app_icon_1024.png                    uygulama ikonunun ana görseli
├─ store\                                       mağaza görselleri (uygulamaya girmez)
│  ├─ ekran_goruntuleri\
│  │  ├─ iphone_6.3_1206x2622_YUKLENEN\         App Store'a YÜKLENEN 5 görsel
│  │  └─ iphone_6.9_1320x2868\                  aynı görsellerin büyük boyu (yedek)
│  ├─ abonelik_inceleme_gorseli\                abonelik "Review Information" görseli (1290×2796)
│  └─ ikon\
│     ├─ app_icon_1024_kamera_S.png             seçilen ikon
│     └─ taslaklar\                             A klasik kamera · B deklanşör · C kamera+S (seçilen)
├─ docs\                                        GitHub Pages: gizlilik politikası + destek sayfası
│  ├─ index.html  privacy.html  style.css
├─ ios\  android\  windows\                     platform projeleri
├─ codemagic.yaml                               bulut derleme (TestFlight / App Store akışları)
├─ l10n.yaml                                    çeviri üretim ayarı
├─ pubspec.yaml                                 paketler, sürüm (1.0.0+1), fontlar
├─ analysis_options.yaml                        lint kuralları
├─ kurulum.bat  tool\platform_ayarla.ps1         ilk kurulum betikleri (Windows)
└─ .gitattributes .gitignore

C:\Users\burak\source\Shootly_Gizli_Anahtarlar\  ← GİZLİ (GitHub'a GİTMEZ, yedekle, paylaşma)
├─ BENI_OKU.txt                                  her anahtarın ne olduğu, Key ID'ler, Issuer ID
├─ 1_AppStoreConnect_API_Anahtari_Codemagic\     AuthKey_N5PRSPHUH5.p8
├─ 2_AppStoreConnect_API_Anahtari_RevenueCat_Finance\  AuthKey_6J55JP534N.p8 (kullanılmıyor)
├─ 3_InApp_Purchase_Anahtari_RevenueCat\         SubscriptionKey_K9KQJ9X4VT.p8
├─ 4_Dagitim_Sertifikasi_Codemagic\              shootly_dagitim.p12
├─ 5_Provisioning_Profili_AppStore\              Shootly_App_Store.mobileprovision
└─ 6_Abonelik_Inceleme_Gorseli\
```

> ⚠️ Proje klasörü herkese açık. Anahtar, sertifika, şifre, telefon numarası gibi bilgiler **asla**
> `vitrin\` içine konmaz; hepsi `Shootly_Gizli_Anahtarlar\` klasöründedir.

---

## 4. Bağlantılar ve hesaplar

### Herkese açık
| Ne | Adres |
|---|---|
| Kaynak kod | https://github.com/burak01kol/shootly |
| Gizlilik politikası | https://burak01kol.github.io/shootly/privacy.html |
| Destek sayfası | https://burak01kol.github.io/shootly/ |
| Kullanım koşulları (Apple EULA) | https://www.apple.com/legal/internet-services/itunes/dev/stdeula/ |
| Destek e-postası | kol.burak@icloud.com |

### Apple
| Ne | Değer / adres |
|---|---|
| Geliştirici hesabı | Burak KOL (bireysel) · Team ID `54GXF32H4L` |
| Bundle ID | `com.burakkol.shootly` |
| App Store Apple ID | `6828748444` · SKU `shootly-ios` |
| App Store Connect | https://appstoreconnect.apple.com/apps/6828748444/distribution/ios/version/inflight |
| TestFlight | https://appstoreconnect.apple.com/apps/6828748444/testflight/ios |
| Abonelikler | https://appstoreconnect.apple.com/apps/6828748444/distribution/subscriptions |
| Abonelik grubu | Shootly Pro · Group ID `22529628` |
| Sertifikalar / profiller | https://developer.apple.com/account/resources/identifiers/list |
| API anahtarları | https://appstoreconnect.apple.com/access/integrations/api |
| In-App Purchase anahtarları | https://appstoreconnect.apple.com/access/integrations/in-app-purchase |
| Ödemeler / sözleşmeler | https://appstoreconnect.apple.com/business |
| Eski uygulama | **One Number** — Shootly ile ilgisi yok, dokunulmaz |

### RevenueCat (abonelik yönetimi)
| Ne | Değer |
|---|---|
| Panel | https://app.revenuecat.com/projects/3a2e94fb |
| Proje | Shootly |
| Uygulama | Shootly (App Store) · `com.burakkol.shootly` |
| Yetki (entitlement) | **`pro`** (küçük harf — kod bunu arar) |
| Offering | `default` (Current) → `$rc_annual` = shootly_pro_yearly, `$rc_monthly` = shootly_pro_monthly |
| Paywall | `default` offering'e bağlı, yayında |
| iOS anahtarı | `appl_...` → Codemagic'te `RC_IOS_KEY` |

### Codemagic (bulut Mac ile derleme)
| Ne | Değer |
|---|---|
| Uygulama | https://codemagic.io/app/6ae49127c68618bdd8de1013 |
| Hesap | GitHub ile giriş (e-posta: gizli klasördeki `BENI_OKU.txt`) |
| App Store Connect entegrasyonu | `ShootlyKey` (Key ID N5PRSPHUH5) |
| İmza sertifikası | `shootly_dagitim` (Apple Distribution, 30.10.2027'ye kadar) |
| Profil | `shootly_profil` → "Shootly App Store" |
| Değişken grubu | `shootly` → `RC_IOS_KEY` (Secret) |

---

## 5. Özellikler (ayrıntılı)

### 5.1 Fotoğraf alma
- **Deklanşör butonu** (ana sayfanın ortası): telefonda kamerayı açar; masaüstünde (Windows) galeri seçicisini açar.
- **Galeriden seç**: ücretsiz planda 1 fotoğraf, Pro'da **tek seferde 8 fotoğraf** (`AppConfig.maxPhotosPerProduct`).
- Fotoğraflar en uzun kenar **3000 px**'e küçültülür, JPEG kalite %95 (`HomePage._maxSide`, `_quality`).
- İzin reddedilirse çökmek yerine açıklama penceresi açılır, **Ayarları aç** ile sistem ayarına gider.

### 5.2 Arka plan silme
- **Tamamen cihazda**: iOS 17+'da Apple Vision, Android'de Google ML Kit (`native_cutout` paketi). İnternet ve sunucu yok.
- Ürün, kendi sınırlarına göre kırpılmış şeffaf PNG olarak çıkar (`Cutout`).
- Birden fazla fotoğraf **sırayla** işlenir (bellek düşük kalsın diye).
- Ürün bulunamazsa: "Fotoğrafta ürün bulunamadı. Ürünü ortalayıp tekrar çek." · başka hata: "Fotoğraf işlenemedi" + **Tekrar dene**.
- Açılışta model önceden hazırlanır (`warmUp`), ilk fotoğrafta bekleme olmasın diye.

### 5.3 Ölçü (çıktı boyutu)
| Seçenek | Ölçü (px) | Ürünün kaplama oranı | Plan |
|---|---|---|---|
| **Trendyol** (varsayılan) | 1200 × 1800 (dikey 2:3) | %85 | Ücretsiz |
| Hepsiburada | 1500 × 1500 | %85 | Pro |
| n11 | 1200 × 1200 | %85 | Pro |
| Amazon | 2000 × 2000 | %85 | Pro |
| Etsy | 2000 × 2000 | %80 | Pro |
| Instagram | 1080 × 1350 (4:5) | %75 | Pro |
| **Orijinal** | ürünün kendi oranı, uzun kenar 2000 | %90 | Ücretsiz |
| **Özel** | 200–5000 px arası her ölçü | %85 | Pro |

Özel ölçü penceresindeki hazır oranlar: **Kare 1:1** (2000×2000) · **Dikey 4:5** (1600×2000) · **Portre 3:4** (1500×2000) · **Hikâye 9:16** (1080×1920) · **Yatay 16:9** (1920×1080).
Ölçüler `lib/core/models/marketplace.dart` ve `canvas_size.dart` içinde; pazaryeri kuralı değişirse tek satır güncellenir.

### 5.4 Zemin ve gölge
| Zemin | Renk | Plan |
|---|---|---|
| Beyaz | `#FFFFFF` | Ücretsiz |
| Açık gri | `#F1F2F4` | Pro |
| Krem | `#F6F0E4` | Pro |
| Mavi | `#E4EEF9` | Pro |
| Pembe | `#FAE7EA` | Pro |
| Siyah | `#141414` | Pro |

**Zemin gölgesi** (Pro): ürünün altına kenarlara doğru yumuşayan eliptik gölge (`ImageComposer._drawFloorShadow`).

### 5.5 Dışa aktarma
- **Hazırla ve kaydet** tek butonu: görselleri üretir **ve** galeriye kaydeder.
- Dosya adı: **barkod / ürün kodu** girilirse `8690000000001_1.jpg`, `_2.jpg`…; boşsa `urun_1.jpg`. Türkçe karakter ve boşluk temizlenir (`ExportService.fileBaseName`).
- JPEG kalite %92; ağır iş ayrı **isolate**'te çalışır (arayüz donmaz).
- Galeri albümü: **Shootly**.
- Sonuç ekranı: kaydedildi / izin yok / kaydedilemedi durumları, **Paylaş** (sistem paylaşım menüsü), **Yeni çekim**.

### 5.6 Hatırlanan ayarlar
Son seçilen ölçü, pazaryeri, özel ölçü değerleri, zemin ve gölge saklanır; bir sonraki çekimde aynı gelir. Pro aboneliği biterse Pro ayarları otomatik ücretsiz varsayılana döner (`EditorPage._startingSettings`).

### 5.7 Günlük ücretsiz hak
Ücretsiz planda **günde 3** dışa aktarma (`AppConfig.freeDailyExports`), gece yarısı yenilenir (`UsageLimiter`). Ana sayfada "Bugün 3 ücretsiz hakkın var · Sınırsız yap".

### 5.8 Diğer
- **Tanıtım (onboarding)**: 3 slayt (Tek dokunuşla çek · Arka plan saniyede gider · Pazaryerine hazır); Ayarlar'dan tekrar gösterilebilir.
- **Dil**: Ayarlar → Dil → Türkçe / English (bkz. bölüm 11).
- **Ayarlar ekranı**: Pro kartı, satın alımları geri yükle, gizlilik politikası, kullanım koşulları, destek, dil, tanıtım, sürüm, "fotoğrafların cihazında işlenir" notu.

---

## 6. Ücretsiz ve Pro

| | Ücretsiz | Pro |
|---|---|---|
| Günlük dışa aktarma | 3 | Sınırsız |
| Ölçü | Trendyol + Orijinal | Tüm pazaryerleri + Özel ölçü |
| Zemin | Beyaz | 6 renk |
| Zemin gölgesi | — | ✓ |
| Tek seferde fotoğraf | 1 | 8 |
| Arka plan silme, barkodla adlandırma, kaydetme, paylaşma | ✓ | ✓ |

Pro kontrolü **tek yerde**: `ExportSettings.needsPro` + `Marketplace.isFree` / `Backdrop.isFree` / `SizeMode.isFree`.
Kilitli seçeneğe dokununca paywall açılır; satın alınmazsa ayar değişmez.

### Fiyatlar (Türkiye)
| Ürün | Product ID | Süre | Fiyat | Teklif |
|---|---|---|---|---|
| Shootly Pro Aylık | `shootly_pro_monthly` | 1 ay | ₺149,99 | — (aile paylaşımı **açık**, kapatılamaz) |
| Shootly Pro Yıllık | `shootly_pro_yearly` | 1 yıl | App Store Connect'te seçilen fiyat | 3 gün ücretsiz (31.12.2026'ya kadar; uzatılmalı) |

**Fiyat gerekçesi (Ekim 2026, TR App Store araştırması):** Photoroom, Pixelcut, Picsart Plus yıllıkta ₺799,99;
aylıkta Picsart Plus ₺119,99, Pixelcut ₺129,99, PicWish ₺229,99. ₺129,99 kademesi bulunmadığı için aylık ₺149,99 seçildi;
yıllığın rakiplerin altında kalması (öneri ₺699,99) kullanıcıyı yıllığa yönlendirir.

**Gelir hesabı (yaklaşık, yıllık ₺699,99 örneği):** KDV %20 (Apple öder) → Apple komisyonu %15 (Small Business Program'a başvurulursa, yoksa %30) → kalan ≈ ₺496. RevenueCat aylık 2.500$ gelire kadar ücretsiz. Ödemeler ayda bir TL banka hesabına.

---

## 7. Ekranlar

| Ekran | Dosya | İçerik |
|---|---|---|
| Tanıtım | `features/onboarding/onboarding_page.dart` | 3 slayt, Geç / Devam / Hadi başlayalım |
| Ana sayfa | `features/home/home_page.dart` | Logo, Pro rozeti / Pro'ya geç, ayarlar, "Çek. Gerisini Shootly halleder.", büyük deklanşör, galeriden seç, kalan hak |
| Önizleme / düzenleme | `features/editor/editor_page.dart` | Canlı önizleme, fotoğraf şeridi, ölçü / zemin / gölge, barkod kutusu, **Hazırla ve kaydet** |
| Özel ölçü | `features/editor/widgets/custom_size_sheet.dart` | Hazır oranlar + genişlik × yükseklik |
| Sonuç | `features/export/export_result_page.dart` | Hazır!, görseller, Paylaş, Yeni çekim |
| Ayarlar | `features/settings/settings_page.dart` | Pro kartı, hesap, yasal ve destek, uygulama |
| Dil seçimi | `features/settings/widgets/language_sheet.dart` | Türkçe / English |
| İzin penceresi | `core/widgets/permission_sheet.dart` | Kamera / fotoğraflar / galeriye kaydetme reddedilince |
| Abonelik ekranı (paywall) | RevenueCat panelinde tasarlanır | Shootly Pro, 4 özellik, yıllık (3 gün ücretsiz) / aylık, Devam et, geri yükle, gizlilik, koşullar |

Ekranların görselleri: `store/ekran_goruntuleri/`.

---

## 8. Tasarım sistemi

**Kural: yalnızca beyaz + siyah (+ gri tonları). Turuncu ya da başka vurgu rengi YOK.**

| Ad (`ShootlyColors`) | Renk | Kullanım |
|---|---|---|
| `background` | `#FFFFFF` | Zemin |
| `surface` | `#F5F5F7` | Kartlar, kutular, etiketler |
| `ink` | `#0B0B0F` | Yazı, ana buton, seçili öğe |
| `muted` | `#6E6E78` | İkincil yazı |
| `line` | `#E6E6EB` | Çerçeve, ayraç |

- **Yazı tipi:** Plus Jakarta Sans (Regular/Medium/SemiBold/Bold/ExtraBold), uygulamaya gömülü, internetsiz çalışır, Türkçe karakter ve ₺ destekli.
- Başlıklar ExtraBold, sıkı harf aralığı; butonlar 58 px yükseklik, 18 px köşe.
- Sadece **açık tema** ve **dikey ekran**.
- Tema tek dosyada: `lib/app/theme.dart`.
- **İkon:** beyaz zemin, siyah kamera gövdesi, lensin içinde beyaz **S** (taslaklar `store/ikon/taslaklar/`). Önceki siyah zeminli "S." ikonu One Number'a benzediği için bırakıldı.
- **Logo:** "Shootly." (`ShootlyWordmark`).

---

## 9. Mimari ve kod haritası

### İlkeler
- **Katmanlar:** `core/` (modeller + servisler, Flutter widget'ı bilmez) → `features/` (ekranlar).
- **Bağımlılık:** tüm servisler `AppServices` içinde; ekranlar `ServicesScope.of(context)` ile erişir. Testte sahteleri verilir.
- **Durum:** `ChangeNotifier` + `ListenableBuilder` (ek paket yok).
- **Arayüz arkasında servisler:** `BackgroundRemover`, `SubscriptionService` (gerçek + geliştirme modu).
- **Metinler** sadece `lib/l10n/*.arb` içinde; kodda sabit metin yok.

### Dosyalar
| Dosya | Görev |
|---|---|
| `main.dart` | Servisleri oluşturur, uygulamayı başlatır |
| `app/app.dart` | `MaterialApp`, tema, seçili dil, ilk açılış yönlendirmesi |
| `app/theme.dart` | Renkler (`ShootlyColors`) ve Material 3 teması |
| `app/l10n.dart` | `context.l10n` kısayolu |
| `core/config/app_config.dart` | Sabitler: ad, sürüm, RevenueCat anahtarları (dart-define), `pro`, günlük hak, foto sınırı, albüm, web adresleri |
| `core/di/app_services.dart` | Servislerin kurulumu; anahtar yoksa geliştirme modu |
| `core/models/marketplace.dart` | Pazaryeri ölçüleri |
| `core/models/backdrop.dart` | Zemin renkleri |
| `core/models/canvas_size.dart` | `SizeMode` (pazaryeri/orijinal/özel) ve `CanvasSize` |
| `core/models/export_settings.dart` | Tüm dışa aktarma ayarları, `needsPro`, `canvasFor` |
| `core/models/cutout.dart` | Kesilmiş ürün görseli (yol + boyut) |
| `core/services/background_remover.dart` | Cihaz üstü arka plan silme, hata nedenleri (`RemovalFailure`) |
| `core/services/image_composer.dart` | Tuval + ortalama + gölge + JPG (saf Dart, isolate) |
| `core/services/export_service.dart` | Dosya üretme, galeriye kaydetme (`GallerySaveResult`), paylaşma |
| `core/services/subscription_service.dart` | RevenueCat servisi + geliştirme modu servisi (**dokunulmaz, bkz. 19**) |
| `core/services/usage_limiter.dart` | Günlük ücretsiz hak sayacı |
| `core/services/app_preferences.dart` | Kalıcı tercihler (tanıtım, dil, son ayarlar) |
| `core/services/language_controller.dart` | TR/EN seçimi |
| `core/widgets/*` | İzin penceresi, Pro kilit etiketi, logo |
| `features/editor/editor_controller.dart` | Fotoğraf işleme durumu, ayarlar |
| `features/editor/widgets/*` | Önizleme, fotoğraf şeridi, ayar paneli, özel ölçü penceresi |
| `features/*` | Ekranlar (bölüm 7) |

### Paketler (`pubspec.yaml`)
| Paket | Ne için |
|---|---|
| `native_cutout` | Cihaz üstü arka plan silme (Apple Vision / ML Kit) |
| `image` | Görsel birleştirme, JPG kodlama |
| `image_picker` | Kamera ve galeri |
| `gal` | Galeriye (albüme) kaydetme |
| `share_plus` | Paylaşım menüsü |
| `path_provider` | Geçici dosya klasörü |
| `shared_preferences` | Kalıcı tercihler |
| `purchases_flutter`, `purchases_ui_flutter` | RevenueCat abonelik + paywall |
| `url_launcher` | Gizlilik / koşul / destek bağlantıları |
| `app_settings` | İzin reddinde sistem ayarlarını açma |
| `flutter_localizations` | TR/EN dil desteği |

---

## 10. Veri akışı: bir fotoğrafın yolculuğu

```
Deklanşör / Galeri  (HomePage)
   │  image_picker → en fazla 3000 px JPEG
   ▼
EditorPage → EditorController.processAll()
   │  BackgroundRemover.removeBackground()  — cihazda, internetsiz
   │  → Cutout (şeffaf PNG, ürüne göre kırpılmış)
   ▼
PreviewCanvas  — seçili ölçü/zemin/gölgeyle canlı önizleme
   │  kullanıcı isterse ölçü, zemin, gölge, barkod değiştirir (Pro ise paywall)
   ▼
"Hazırla ve kaydet"
   │  ExportService.export()  → ImageComposer.compose() (isolate)
   │  → barkod_1.jpg, barkod_2.jpg … (geçici klasör)
   │  ExportService.saveToGallery() → "Shootly" albümü
   │  UsageLimiter.recordExport() (ücretsiz plan)
   ▼
ExportResultPage  — Hazır! · Paylaş · Yeni çekim
```

Fotoğraf hiçbir aşamada cihazdan çıkmaz.

---

## 11. Dil desteği

- **Varsayılan Türkçe**, Ayarlar → Dil ile **English**; seçim kalıcı (`app.language`).
- Metinler: `lib/l10n/app_tr.arb` (ana) ve `app_en.arb` — **97 metin**; `flutter gen-l10n` ile `app_localizations*.dart` üretilir.
- İngilizcede tekil/çoğul doğru ("1 photo", "3 photos").
- Yeni metin eklemek: iki ARB dosyasına da ekle → `flutter gen-l10n` (ya da `flutter pub get`).
- iOS uygulama dilleri: `tr`, `en`. **Not:** iPhone'un kendi izin pencereleri (Info.plist metinleri) şimdilik yalnızca Türkçe.

---

## 12. Ödeme ve abonelik altyapısı

```
Kullanıcı "Pro'ya geç" → RevenueCat paywall (presentPaywallIfNeeded("pro"))
   → Apple ödeme penceresi (Face ID) → Apple tahsil eder
   → RevenueCat "pro" yetkisini açar → uygulama kilitleri kaldırır
```

- Kod: `core/services/subscription_service.dart` — **RevenueCatSubscriptionService** (gerçek) ve **DevSubscriptionService** (anahtar yoksa: "Pro'ya geç" ödemesiz Pro açar; ana sayfada "Geliştirme modu" notu).
- Anahtar derlemede verilir: `--dart-define=RC_IOS_KEY=appl_...` (Android: `RC_ANDROID_KEY`).
- App Store derlemesi anahtar olmadan **başlamaz** (`codemagic.yaml` → "Yayın kontrolleri").
- Geri yükleme: Ayarlar → Satın alımları geri yükle.
- Paywall Apple kuralları: fiyat + süre (değişkenle, yerel para birimiyle), "Yıllıkta ilk 3 gün ücretsiz", otomatik yenileme açıklaması, geri yükle, gizlilik ve koşullar bağlantıları.

---

## 13. Gizlilik, izinler ve veri

| İzin | Ne zaman istenir | Metin (Info.plist) |
|---|---|---|
| Kamera | Deklanşöre basınca | "Ürününün fotoğrafını çekebilmen için Shootly kameraya erişmek istiyor. Fotoğraflar yalnızca cihazında işlenir." |
| Fotoğraflar | Galeriden seçince | "Galeriden ürün fotoğrafı seçebilmen için…" |
| Fotoğraflara ekleme | Kaydederken | "Hazırlanan ürün görsellerini galerine kaydedebilmek için…" |

- **Toplanan veri (App Store gizlilik etiketi):** Purchases → Purchase History, Identifiers → User ID (RevenueCat'in anonim kimliği). Amaç: App Functionality · kullanıcıya bağlı değil · takip yok → mağazada **"Data Not Linked to You"**.
- Fotoğraf, konum, kişi, kullanım verisi **toplanmaz**. Reklam ve takip yok.
- Gizlilik politikası ve destek sayfası: `docs/` (GitHub Pages).
- Şifreleme beyanı: `ITSAppUsesNonExemptEncryption = NO`.
- Eklenti gizlilik manifestoları (PrivacyInfo.xcprivacy) kontrol edildi.

---

## 14. Platform ayarları

### iOS (yayında)
- Bundle ID `com.burakkol.shootly` · **iOS 17.0+** (Apple Vision ön plan maskesi için) · **yalnız iPhone** · **yalnız dikey**.
- `ios/Podfile` → `platform :ios, '17.0'`.
- Uygulama adı "Shootly", dil `tr` (+ `en`), ikon 19 boyut (saydamlık yok).

### Android (sonraki aşama)
- `applicationId` hâlâ eski: **`com.vitrinapp.vitrin`** → Play Store'a ilk yüklemeden **önce** `com.burakkol.shootly` yapılmalı (sonra değişmez).
- minSdk 24, `FlutterFragmentActivity` (RevenueCat paywall için), NDK 28.2.13676358 (Flutter zorunlu tutuyor).
- Android SDK: `C:\Users\burak\AppData\Local\Android\Sdk` (platform-36, build-tools 36.0.0, platform-tools, cmdline-tools).

### Windows (sadece geliştirme)
- Arayüzü denemek için: `flutter run -d windows` ya da `build\windows\x64\runner\Debug\shootly.exe`.
- Arka plan silme, kamera ve galeriye kaydetme Windows'ta **çalışmaz** (paketler yalnız iOS/Android).
- Derlemek için Windows **Geliştirici Modu** açık olmalı.

---

## 15. Derleme ve yayın (Codemagic)

Windows'ta Mac olmadığı için iOS derlemesi **Codemagic**'in bulut Mac'inde yapılır:

```
Kod (Windows) → git push (GitHub) → Codemagic derler + imzalar → App Store Connect
```

| Akış | Ne zaman | Özellik |
|---|---|---|
| **iOS — TestFlight (deneme)** | Telefonda denemek | RevenueCat anahtarı yoksa geliştirme modunda açılır; sadece App Store Connect'e yükler |
| **iOS — App Store (inceleme)** | Mağazaya gidecek sürüm | Önce kontrol: `RC_IOS_KEY` var mı, web adresleri gerçek mi; yoksa durur |

Adımlar: Xcode imza ayarları → `flutter pub get` → `flutter analyze` + `flutter test` → IPA derle (derleme numarası = TestFlight'taki son numara + 1) → App Store Connect'e yükle.
Bir derleme ~10–15 dk; ücretsiz plan ayda 500 dk.

**Yeni sürüm çıkarmak:**
1. `pubspec.yaml` → `version: 1.0.1+1` (ve `AppConfig.appVersion`)
2. commit + push
3. Codemagic → Start new build → **iOS — App Store (inceleme)**
4. App Store Connect → yeni sürüm (1.0.1) → derlemeyi seç → Add for Review → Submit

Ayrıntılı rehber: `belgeler/APP_STORE_YAYIN_REHBERI.md`.

---

## 16. App Store kaydı ve mağaza bilgileri

| Alan | Değer |
|---|---|
| Ad | Shootly |
| Alt başlık | Tek dokunuşla ürün fotoğrafı |
| Kategori | Photo & Video · ikinci: Business |
| Yaş | 4+ |
| Ana dil | Türkçe |
| Fiyat | Ücretsiz (abonelikle) |
| Ülkeler | **Yalnızca Türkiye** (AB "trader" beyanı yapılmadı) |
| Yayın | Onaydan sonra **otomatik** |
| Telif | 2026 Burak Kol |
| Content Rights | Üçüncü taraf içerik yok |
| Lisans | Apple standart EULA |
| Ekran görüntüleri | 5 adet, iPhone 6.3" (1206×2622) — `store/ekran_goruntuleri/iphone_6.3_1206x2622_YUKLENEN` |
| Anahtar kelimeler | arka plan silme,ürün fotoğrafı,pazaryeri,e-ticaret,beyaz zemin,katalog,satıcı,dekupe,stüdyo,ilan |
| İnceleme | Giriş gerekmiyor; test adımları ve abonelik yeri notta anlatıldı |

Tanıtım metni, açıklama ve inceleme notunun tam hali: `belgeler/APP_STORE_YAYIN_REHBERI.md`.

**Banka / vergi:** Paid Apps sözleşmesi imzalandı; banka (TRY) ve W-8BEN (Türkiye, 12(2)(b), %10) gönderildi — onay bekleniyor. AB DSA "trader" beyanı yapılmadı.

---

## 17. Testler ve kalite

| Test dosyası | Ne doğrular |
|---|---|
| `image_composer_test.dart` | Tuval ölçüsü, zemin rengi, ortalama, gölge, bozuk veri hatası |
| `export_test.dart` | Dosya adı temizleme, Pro kuralları, ölçü hesabı (pazaryeri/özel/orijinal), sınırlar |
| `usage_limiter_test.dart` | Günlük hak düşümü, sıfırın altına inmeme, ertesi gün yenilenme |
| `app_preferences_test.dart` | Ayarların kaydı/okunması, bozuk değerde varsayılan, tanıtımın sıfırlanması |
| `language_controller_test.dart` | Varsayılan Türkçe, kalıcı seçim, bilinmeyen dilde Türkçe |
| `widget_test.dart` | Pro kilit etiketi |

**26 test**, hepsi geçiyor · `flutter analyze` temiz · Codemagic her derlemede ikisini de çalıştırır.

---

## 18. Geliştirme ortamı ve komutlar

| Araç | Konum / sürüm |
|---|---|
| Flutter | `C:\src\flutter` · 3.47.8 · Dart 3.13.7 |
| Android SDK | `C:\Users\burak\AppData\Local\Android\Sdk` |
| Android Studio JDK | `C:\Program Files\Android\Android Studio\jbr` |
| Visual Studio 2026 | Windows masaüstü derlemesi için |

```bash
flutter pub get            # paketler + çeviri kodu
flutter analyze            # kod kontrolü
flutter test               # testler
flutter run -d windows     # arayüzü Windows'ta dene
flutter gen-l10n           # ARB değişince çeviri kodunu üret
```

---

## 19. Proje kuralları

1. **Renk:** yalnızca beyaz + siyah + gri. Turuncu/renkli vurgu kullanılmaz.
2. **Her `.dart` dosyası** 2–3 satır `///` DartDoc açıklamasıyla ve `library;` satırıyla başlar.
3. **Ödeme koduna** (`subscription_service.dart`, RevenueCat paywall akışı) kullanıcı onayı olmadan dokunulmaz.
4. **Metinler** kodda değil, iki ARB dosyasında.
5. **Gizli bilgiler** proje klasörüne konmaz (repo herkese açık).
6. **Büyük indirmeler** (~50 MB üstü) önce sorulur — internet kısıtlı.
7. Anahtar kelimelerde başka markaların adı (Trendyol vb.) kullanılmaz (App Store kuralı 2.3.7).
8. Gizlilik/koşul bağlantıları ve "Satın alımları geri yükle" her zaman Ayarlar'da kalır.

---

## 20. Karşılaşılan sorunlar ve çözümleri

| Sorun | Çözüm |
|---|---|
| Android derlemesi NDK istedi | NDK 28.2.13676358 kuruldu (Flutter Gradle eklentisi zorunlu tutuyor) |
| Windows derlemesi "symlink" hatası | Windows Geliştirici Modu açıldı |
| iPhone'a Windows'tan yükleme imkânsız | Codemagic bulut Mac kullanıldı |
| İlk derlemede "post-processing failed" | TestFlight beta incelemesine gönderme kapatıldı (`submit_to_testflight: false`) |
| App Store sayfasına 0.1.0 derlemesi eklenemedi | Sürüm 1.0.0 yapıldı (App Store kaydı 1.0) |
| Ekran görüntüsü "boyut geçersiz" | 6.3" slot için 1206×2622'ye ölçeklendi |
| Abonelik inceleme görseli reddedildi | 1290×2796'ya getirildi |
| RevenueCat ".p8 dosya adı geçersiz" | App Store Connect API değil **In-App Purchase** anahtarı (`SubscriptionKey_…`) kullanıldı, ad değiştirilmedi |
| Yetki "Pro" (büyük P) oluşturuldu | Silinip **`pro`** olarak yeniden oluşturuldu |
| ₺129,99 fiyat kademesi yok | Aylık ₺149,99 seçildi |
| Anahtar kelime alanına açıklama yapıştırıldı | Kısa virgüllü listeyle değiştirildi |
| "Sign-in required" işaretliydi | Kaldırıldı (uygulamada giriş yok) |
| Gönderimde "abonelik grubuyla gönderilmeli" | Grup + 2 abonelik + sürüm aynı taslağa eklendi |

---

## 21. Yol haritası

**Hemen**
- [ ] Apple inceleme sonucunu takip et (red gelirse mesajı oku, düzelt, tekrar gönder)
- [ ] Paid Apps sözleşmesinin **Active** olmasını bekle; olmadıysa abonelik satışı başlamaz
- [ ] Yıllık abonelikteki 3 gün denemenin bitiş tarihini (31.12.2026) **"No End Date"** yap
- [ ] Small Business Program'a başvur (komisyon %30 → %15)
- [ ] Gizli anahtar klasörünü yedekle; sertifika şifresini şifre yöneticisine koy
- [ ] Business sayfasındaki adresi tam adresle güncelle (24 saatlik kilit bitince)

**Kısa vade**
- [ ] Gerçek ürün fotoğraflarıyla yeni mağaza ekran görüntüleri
- [ ] Abonelik seviyelerini eşitle (ikisi de Level 1)
- [ ] İzin pencerelerinin İngilizce metinleri (InfoPlist.strings)
- [ ] TestFlight'ta gerçek iPhone denemesi (iç test grubu)

**Android / Play Store**
- [ ] `applicationId` → `com.burakkol.shootly`
- [ ] Play Console hesabı (25$), Play abonelikleri, RevenueCat'e Play Store uygulaması, `RC_ANDROID_KEY`
- [ ] Codemagic'e Android akışı

**Büyüme**
- [ ] AB için DSA "trader" beyanı + ülkeleri genişletme
- [ ] Haftalık paket / kampanya teklifleri (gerekirse)
