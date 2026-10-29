/// [ImageComposer] için birim testleri: tuval ölçüsü, zemin rengi,
/// ürünün ortalanması, gölge ve bozuk veri hatası.
library;

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:vitrin/core/services/image_composer.dart';

void main() {
  // 10x10 tamamen kırmızı, şeffaf zeminli "ürün".
  final redSquare = img.encodePng(
    img.fill(
      img.Image(width: 10, height: 10, numChannels: 4),
      color: img.ColorRgba8(255, 0, 0, 255),
    ),
  );

  ComposeRequest request({bool shadow = false}) => ComposeRequest(
        cutoutPng: redSquare,
        width: 100,
        height: 200,
        fill: 0.5,
        backgroundArgb: 0xFFFFFFFF,
        shadow: shadow,
      );

  test('tuval istenen ölçüde ve zemin beyaz', () {
    final out = img.decodeJpg(ImageComposer.composeSync(request()))!;
    expect(out.width, 100);
    expect(out.height, 200);
    expect(out.getPixel(2, 2).r, greaterThan(245));
  });

  test('ürün tuvalin ortasına, fill oranında yerleşir', () {
    final out = img.decodeJpg(ImageComposer.composeSync(request()))!;
    // 50x50 ürün, (25,75)-(75,125) arasında olmalı.
    final center = out.getPixel(50, 100);
    expect(center.r, greaterThan(200));
    expect(center.g, lessThan(60));
    expect(out.getPixel(20, 100).g, greaterThan(245));
  });

  test('gölge açıkken ürünün altı koyulaşır', () {
    final plain = img.decodeJpg(ImageComposer.composeSync(request()))!;
    final shaded =
        img.decodeJpg(ImageComposer.composeSync(request(shadow: true)))!;
    expect(shaded.getPixel(50, 127).g, lessThan(plain.getPixel(50, 127).g));
  });

  test('bozuk veri anlaşılır hata verir', () {
    final bad = ComposeRequest(
      cutoutPng: Uint8List.fromList([1, 2, 3, 4]),
      width: 10,
      height: 10,
      fill: 1,
      backgroundArgb: 0xFFFFFFFF,
    );
    expect(() => ImageComposer.composeSync(bad), throwsFormatException);
  });
}
