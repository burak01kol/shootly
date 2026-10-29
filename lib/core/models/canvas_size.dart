/// Çıktı görselinin ölçü modeli: ölçünün nereden geldiği ([SizeMode]) ve
/// hesaplanmış piksel ölçüsü ([CanvasSize]). Saf Dart'tır, UI bilmez.
library;

import 'package:flutter/foundation.dart';

/// Çıktı ölçüsünün kaynağı.
enum SizeMode {
  /// Seçili pazaryerinin hazır ölçüsü (varsayılan).
  marketplace,

  /// Ürünün kendi oranı; serbest, ücretsiz seçenek.
  original,

  /// Kullanıcının girdiği genişlik × yükseklik (Pro).
  custom;

  bool get isFree => this != SizeMode.custom;
}

/// Tuvalin piksel ölçüsü ve ürünün tuvalde kaplayacağı en büyük oran.
@immutable
class CanvasSize {
  const CanvasSize({
    required this.width,
    required this.height,
    required this.fill,
  });

  static const minSide = 200;
  static const maxSide = 5000;

  /// "Orijinal" modunda uzun kenar.
  static const originalLongSide = 2000;

  final int width;
  final int height;

  /// 0-1 arası; ürün hem enine hem boyuna bu oranı aşmaz.
  final double fill;

  double get aspectRatio => width / height;

  /// Kullanıcının girdiği bir kenar geçerli aralıkta mı?
  static bool isValidSide(int? side) =>
      side != null && side >= minSide && side <= maxSide;

  /// Ürünün kendi oranında tuval: uzun kenar [originalLongSide] piksel.
  factory CanvasSize.matching({
    required int subjectWidth,
    required int subjectHeight,
    required double fill,
  }) {
    final landscape = subjectWidth >= subjectHeight;
    final ratio = landscape
        ? subjectHeight / subjectWidth
        : subjectWidth / subjectHeight;
    final shortSide = (originalLongSide * ratio).round().clamp(1, originalLongSide);
    return CanvasSize(
      width: landscape ? originalLongSide : shortSide,
      height: landscape ? shortSide : originalLongSide,
      fill: fill,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is CanvasSize &&
      other.width == width &&
      other.height == height &&
      other.fill == fill;

  @override
  int get hashCode => Object.hash(width, height, fill);

  @override
  String toString() => '$width × $height';
}
