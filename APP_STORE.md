# Shootly — App Store'a ilk yayın

Windows'tan Mac olmadan yayın: kod GitHub'a gider, **Codemagic** (bulut Mac) derler,
imzalar ve App Store Connect'e yükler.

| Bilgi | Değer |
|---|---|
| Uygulama adı | Shootly |
| Paket kimliği (Bundle ID) | `com.burakkol.shootly` — kayıtlı ✅, ilk yüklemeden sonra değişmez |
| App Store Connect Apple ID | `6828748444` ✅ |
| Team ID | `54GXF32H4L` |
| Minimum iOS | 17.0 (arka plan silme Apple Vision ile iOS 17 ister) |
| Cihaz | Yalnızca iPhone, yalnızca dikey |
| Sürüm | 0.1.0 (`pubspec.yaml` → `version`) |

---

## 1. Yer tutucuları doldur (bir kez)

| Nerede | Değer | Durum |
|---|---|---|
| `lib/core/config/app_config.dart` → `_webBase` | `https://burak01kol.github.io/shootly` | ✅ |
| `docs/privacy.html`, `docs/index.html` → destek e-postası | `kol.burak@icloud.com` | ✅ |
| `codemagic.yaml` → `APP_STORE_APPLE_ID` | `6828748444` | ✅ |

`ios-appstore` akışı bunlardan biri eksikse derlemeyi bilerek durdurur.

## 2. GitHub

1. github.com/burak01kol altında **`shootly`** adlı depo aç.
2. Bu klasörü o depoya gönder.
3. Depo → Settings → **Pages** → Source: `Deploy from a branch`, Branch: `main`, klasör: **`/docs`**.
   Birkaç dakika sonra `https://burak01kol.github.io/shootly/privacy.html` açılır.
   > Depo Private ise GitHub Pages ücretli plan ister. O zaman depoyu Public yap
   > ya da yalnızca `docs/` klasörünü ayrı bir Public depoya koy.

## 3. App Store Connect — yeni uygulama

1. **Certificates, Identifiers & Profiles → Identifiers → +** → App IDs → App
   - Bundle ID (Explicit): `com.burakkol.shootly`, açıklama: Shootly
   - Capabilities: **In-App Purchase** (varsayılan açık)
2. **App Store Connect → Apps → + → New App**
   - Platform iOS · Ad **Shootly** · Dil Türkçe · Bundle ID `com.burakkol.shootly` · SKU `shootly-ios`
3. Uygulama → **App Information** → **Apple ID** (sayısal) → `codemagic.yaml` içine yaz.

> "One Number" uygulamana dokunulmaz; Shootly ayrı bir kayıttır.

## 4. API anahtarı (Codemagic'in yükleme yapabilmesi için)

1. App Store Connect → **Users and Access → Integrations → App Store Connect API → Team Keys → +**
   - Ad: `Codemagic`, Erişim: **App Manager**
2. **Issuer ID**, **Key ID** değerlerini not et, `.p8` dosyasını indir. `.p8` yalnızca bir kez indirilebilir, kaybetme.

## 5. Codemagic

1. codemagic.io → GitHub ile giriş → `shootly` deposunu ekle → **codemagic.yaml** kullan.
2. **Team settings → Integrations → Developer Portal → Connect**
   - Ad tam olarak: **`ShootlyKey`** (yaml'daki ad), Issuer ID, Key ID, `.p8`
3. **Code signing identities → iOS certificates → Generate certificate** (App Store dağıtım)
   **iOS provisioning profiles → Fetch profiles** (`com.burakkol.shootly`, App Store)
4. **Environment variables** → grup adı **`shootly`**:
   - `RC_IOS_KEY` = RevenueCat iOS public key (`appl_...`), Secret işaretle
   - Yalnızca `ios-appstore` akışı bu grubu ister; `ios-testflight` grup olmadan da çalışır
     (o zaman uygulama geliştirme modunda açılır).

## 6. İlk derleme → kendi iPhone'unda dene

1. Codemagic → **Start new build** → workflow **`ios-testflight`**.
2. Bitince App Store Connect → **TestFlight**'ta görünür (işlenmesi 5–15 dk).
3. TestFlight → **Internal Testing** → grup oluştur, kendi Apple ID'ni ekle.
4. iPhone'a **TestFlight** uygulamasını kur → Shootly'yi yükle.
5. Kamera, galeriden seçme, arka plan silme ve galeriye kaydetmeyi dene.
   İzni bir kez reddedip "Ayarları aç" penceresinin çıktığını da kontrol et.

## 7. Abonelik (RevenueCat + App Store)

1. App Store Connect → Shootly → **Monetization → Subscriptions**
   - Grup: `Shootly Pro`
   - Ürünler (Türkiye fiyatı; diğer ülkeler için Apple'ın otomatik eşdeğerini kabul et):

     | Product ID | Süre | Fiyat (TR) | Tanıtım teklifi |
     |---|---|---|---|
     | `shootly_pro_monthly` | 1 ay | **₺129,99** | — |
     | `shootly_pro_yearly` | 1 yıl | **₺699,99** | 3 gün ücretsiz deneme (Free Trial) |

   - Görünen ad: "Shootly Pro Aylık" / "Shootly Pro Yıllık"; açıklama:
     "Sınırsız çekim, tüm ölçüler, renkli zemin ve gölge."
   - Her ürüne **inceleme ekran görüntüsü** (paywall'un görüntüsü) ekle.
   - **Neden bu fiyatlar (Ekim 2026, TR App Store):** Photoroom, Pixelcut ve Picsart Plus yıllıkta
     ₺799,99; aylıkta Picsart Plus ₺119,99, Pixelcut ₺129,99. Shootly daha dar kapsamlı ve yeni
     olduğu için yıllıkta pazarın ₺100 altında, aylıkta pazar seviyesinde başlıyor. Satışa göre
     App Store Connect'ten güncelleme yapmadan değiştirilebilir.
2. **Business → Agreements**: *Paid Apps* sözleşmesi, banka ve vergi bilgileri **Active** olmalı.
   Olmazsa abonelikler test edilemez ve inceleme reddedilir.
3. RevenueCat → proje → **App Store** uygulaması ekle (Bundle ID, App Store Connect API anahtarı /
   In-App Purchase key) → ürünleri içe aktar → Entitlement **`pro`** → Offering + **Paywall**.
   - Paywall'da **Gizlilik Politikası** ve **Kullanım Koşulları** bağlantılarını aç, fiyat ve
     dönem net görünsün (Kural 3.1.2).
4. iOS public key'i Codemagic `shootly` grubuna `RC_IOS_KEY` olarak ekle.

## 8. Mağaza bilgileri (App Store sekmesi)

**Ad:** Shootly
**Alt başlık (30):** `Tek dokunuşla ürün fotoğrafı`
**Kategori:** Fotoğraf ve Video · ikinci: İş
**Yaş sınırı:** 4+ (tüm sorular "Hayır")
**Gizlilik politikası URL:** `https://burak01kol.github.io/shootly/privacy.html`
**Destek URL:** `https://burak01kol.github.io/shootly/`
**Telif:** `2026 Burak Kol`

**Tanıtım metni (170):**
> Ürününü çek; arka plan saniyede silinsin, ürün beyaz zemine otursun ve pazaryeri ölçüsünde kaydedilsin.

**Açıklama:**
> Shootly, pazaryeri satıcıları için tek dokunuşla ürün fotoğrafı hazırlar.
>
> • Çek ya da galeriden seç
> • Arka plan cihazında, internetsiz silinir
> • Ürün ortalanır, beyaz zemine oturur
> • Trendyol, Hepsiburada, n11, Amazon, Etsy ve Instagram ölçüleri hazır
> • Orijinal oran ya da kendi özel ölçün
> • Barkodla adlandırılmış dosyalar: barkod_1.jpg, barkod_2.jpg
> • Doğrudan galerine kaydedilir, tek dokunuşla paylaşılır
>
> Fotoğrafların hiçbir sunucuya gönderilmez.
>
> Shootly Pro (aylık veya yıllık abonelik; yıllıkta 3 gün ücretsiz deneme): sınırsız günlük çekim,
> tüm pazaryeri ölçüleri ve özel ölçü, renkli zeminler, zemin gölgesi ve tek seferde 8 fotoğraf. Abonelik, dönem bitmeden en az 24 saat önce
> iptal edilmezse otomatik yenilenir; App Store hesap ayarlarından yönetilebilir.
>
> Kullanım Koşulları: https://www.apple.com/legal/internet-services/itunes/dev/stdeula/

**Anahtar kelimeler (100):**
`arka plan silme,ürün fotoğrafı,pazaryeri,e-ticaret,beyaz zemin,katalog,satıcı,dekupe,stüdyo,ilan`

> Başka şirketlerin marka adlarını (Trendyol, Hepsiburada, n11, Amazon…) anahtar kelimelere
> **yazma**: Kural 2.3.7 gereği red sebebidir. Açıklamada "… ölçülerinde" diye bilgi vermek serbesttir.

**Ekran görüntüleri:** `store/screenshots/` (iPhone 6.9", 1320 × 2868) — en az 3, en fazla 10.

## 9. App Privacy (gizlilik etiketi)

**"Do you or your third-party partners collect data from this app?" → Yes**
(RevenueCat yüzünden; fotoğraflar toplanmaz.)

| Veri türü | Toplanıyor | Kullanıcıya bağlı | Takip | Amaç |
|---|---|---|---|---|
| Purchases → Purchase History | Evet | Hayır | Hayır | App Functionality |
| Identifiers → User ID (anonim RevenueCat kimliği) | Evet | Hayır | Hayır | App Functionality |

Diğer tüm türler (fotoğraf, konum, kişiler, kullanım verisi…) → **toplanmıyor**.
Fotoğraflar yalnızca cihazda işlendiği için "toplanan veri" sayılmaz.

## 10. İnceleme notu (App Review Information → Notes)

> Shootly does not require an account. Background removal runs fully on-device (Apple Vision, iOS 17+);
> photos are never uploaded.
> To test: tap the shutter button, take or pick a photo of any object, then tap "Hazırla ve kaydet"
> to export and save to Photos. Pro features (other marketplace sizes, custom size, colored backdrops,
> shadow) open the subscription paywall. Restore Purchases is in Settings (top-right icon).

**Sign-in required:** Hayır.

## 11. İncelemeye gönder

1. Codemagic → **`ios-appstore`** workflow (anahtar + adresler dolu olmalı).
2. App Store Connect → Shootly → sürüm **0.1.0** → **Build** bölümünden yeni build'i seç.
3. **Export Compliance:** Info.plist'te `ITSAppUsesNonExemptEncryption = NO` olduğu için sorulmaz.
4. Abonelik ürünlerini sürüme ekle ("In-App Purchases and Subscriptions" bölümü), **Submit for Review**.

---

## Red yememek için kontrol listesi

- [ ] TestFlight'ta gerçek iPhone'da tüm akış denendi (kamera, galeri, kaydetme, paylaşma)
- [ ] İzin reddedilince uygulama çökmüyor, "Ayarları aç" penceresi çıkıyor
- [ ] App Store derlemesi `RC_IOS_KEY` ile yapıldı (geliştirme modu notu görünmüyor)
- [ ] Paywall'da fiyat, dönem, deneme süresi, Gizlilik ve Koşullar bağlantıları var
- [ ] Ayarlar'da "Satın alımları geri yükle", Gizlilik, Kullanım koşulları çalışıyor
- [ ] Gizlilik politikası ve destek sayfası açılıyor, e-posta doğru
- [ ] Paid Apps sözleşmesi aktif, abonelik ürünleri "Ready to Submit"
- [ ] Ekran görüntüleri gerçek uygulamayı gösteriyor
- [ ] Açıklamada iOS 17 gerektiği ve abonelik koşulları yazıyor
- [ ] Anahtar kelimelerde marka adı yok (Kural 2.3.7)
- [ ] RevenueCat'te Offering "current" + aylık/yıllık paketler + yayınlanmış Paywall var;
      TestFlight'ta "Pro'ya geç" abonelik ekranını açıyor
