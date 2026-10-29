/// Arka planı silinmiş ürün görselinin değişmez veri modeli.
/// Arka plan silme servisinin çıktısıdır; önizleme ve dışa aktarma bu modeli kullanır.
library;

import 'package:flutter/foundation.dart';

/// Arka planı silinmiş, ürüne göre kırpılmış şeffaf PNG.
@immutable
class Cutout {
  const Cutout({required this.path, required this.width, required this.height});

  final String path;
  final int width;
  final int height;

  double get aspectRatio => width / height;
}
