/// Ürünün arkasına konan düz renkli zemin seçenekleri.
/// Her zeminin rengi ve ücretsiz planda kullanılıp kullanılamayacağı burada; görünen adları çeviri dosyalarında.
library;

import 'dart:ui' show Color;

/// Ürünün arkasına konan düz renkli zeminler.
enum Backdrop {
  white(0xFFFFFFFF, isFree: true),
  lightGrey(0xFFF1F2F4),
  cream(0xFFF6F0E4),
  sky(0xFFE4EEF9),
  blush(0xFFFAE7EA),
  black(0xFF141414);

  const Backdrop(this.argb, {this.isFree = false});

  final int argb;
  final bool isFree;

  Color get color => Color(argb);
}
