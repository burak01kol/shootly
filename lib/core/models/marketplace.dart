/// Desteklenen pazaryerleri ve her birinin görsel ölçüleri.
/// Tuval boyutu, ürünün kaplama oranı ve ücretsiz kullanım bilgisi burada tutulur.
library;

/// Pazaryeri görsel ölçüleri.
///
/// Değerler yaygın önerilere göre seçildi; pazaryerleri kurallarını
/// değiştirebilir, yayından önce satıcı panelinden kontrol edin.
enum Marketplace {
  trendyol('Trendyol', width: 1200, height: 1800, fill: 0.85, isFree: true),
  hepsiburada('Hepsiburada', width: 1500, height: 1500, fill: 0.85),
  n11('n11', width: 1200, height: 1200, fill: 0.85),
  amazon('Amazon', width: 2000, height: 2000, fill: 0.85),
  etsy('Etsy', width: 2000, height: 2000, fill: 0.80),
  instagram('Instagram', width: 1080, height: 1350, fill: 0.75);

  const Marketplace(
    this.label, {
    required this.width,
    required this.height,
    required this.fill,
    this.isFree = false,
  });

  final String label;
  final int width;
  final int height;

  /// Ürünün tuvalde kaplayacağı en büyük oran (0-1).
  final double fill;

  /// Ücretsiz planda kullanılabilir mi?
  final bool isFree;

  double get aspectRatio => width / height;
}
