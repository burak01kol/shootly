/// Ürünün arkasına konan düz renkli zemin seçenekleri.
/// Her zeminin adı, rengi ve ücretsiz planda kullanılıp kullanılamayacağı burada tanımlıdır.
library;

import 'dart:ui' show Color;

/// Ürünün arkasına konan düz renkli zeminler.
enum Backdrop {
  white('Beyaz', 0xFFFFFFFF, isFree: true),
  lightGrey('Açık gri', 0xFFF1F2F4),
  cream('Krem', 0xFFF6F0E4),
  sky('Mavi', 0xFFE4EEF9),
  blush('Pembe', 0xFFFAE7EA),
  black('Siyah', 0xFF141414);

  const Backdrop(this.label, this.argb, {this.isFree = false});

  final String label;
  final int argb;
  final bool isFree;

  Color get color => Color(argb);
}
