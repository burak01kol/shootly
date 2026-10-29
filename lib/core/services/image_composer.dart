/// Ürünü pazaryeri tuvaline yerleştirip JPG üreten saf Dart görsel birleştirici.
/// Ortalama, ölçekleme ve zemin gölgesini yapar; ağır iş ayrı bir isolate'te çalışır.
library;

import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Kesilmiş ürünü pazaryeri tuvaline yerleştirme isteği.
class ComposeRequest {
  const ComposeRequest({
    required this.cutoutPng,
    required this.width,
    required this.height,
    required this.fill,
    required this.backgroundArgb,
    this.shadow = false,
    this.jpgQuality = 92,
  });

  final Uint8List cutoutPng;
  final int width;
  final int height;
  final double fill;
  final int backgroundArgb;
  final bool shadow;
  final int jpgQuality;
}

/// Ürünü tuvalin ortasına yerleştirir, isteğe bağlı gölge ekler, JPG üretir.
/// Saf Dart'tır (test edilebilir); ağır iş ayrı bir isolate'te çalışır.
class ImageComposer {
  const ImageComposer();

  Future<Uint8List> compose(ComposeRequest request) =>
      Isolate.run(() => composeSync(request));

  static Uint8List composeSync(ComposeRequest request) {
    final decoded = img.decodePng(request.cutoutPng);
    if (decoded == null) {
      throw const FormatException('Kesilmiş görsel okunamadı.');
    }
    final subject = decoded.convert(numChannels: 4);

    final canvas = img.Image(width: request.width, height: request.height);
    img.fill(canvas, color: _rgb(request.backgroundArgb));

    final scale = math.min(
      request.width * request.fill / subject.width,
      request.height * request.fill / subject.height,
    );
    final w = math.max(1, (subject.width * scale).round());
    final h = math.max(1, (subject.height * scale).round());
    final resized = img.copyResize(
      subject,
      width: w,
      height: h,
      interpolation: img.Interpolation.cubic,
    );
    final x = (request.width - w) ~/ 2;
    final y = (request.height - h) ~/ 2;

    if (request.shadow) {
      _drawFloorShadow(
        canvas,
        centerX: x + w / 2,
        bottomY: (y + h).toDouble(),
        radiusX: w * 0.45,
        radiusY: math.max(3.0, h * 0.08),
      );
    }
    img.compositeImage(canvas, resized, dstX: x, dstY: y);
    return img.encodeJpg(canvas, quality: request.jpgQuality);
  }

  static img.ColorRgb8 _rgb(int argb) =>
      img.ColorRgb8((argb >> 16) & 0xFF, (argb >> 8) & 0xFF, argb & 0xFF);

  /// Ürünün altına, kenarlara doğru yumuşayan eliptik bir zemin gölgesi çizer.
  static void _drawFloorShadow(
    img.Image canvas, {
    required double centerX,
    required double bottomY,
    required double radiusX,
    required double radiusY,
  }) {
    const maxOpacity = 0.35;
    final left = math.max(0, (centerX - radiusX).floor());
    final right = math.min(canvas.width - 1, (centerX + radiusX).ceil());
    final top = math.max(0, (bottomY - radiusY).floor());
    final bottom = math.min(canvas.height - 1, (bottomY + radiusY).ceil());

    for (var py = top; py <= bottom; py++) {
      for (var px = left; px <= right; px++) {
        final dx = (px - centerX) / radiusX;
        final dy = (py - bottomY) / radiusY;
        final distance = math.sqrt(dx * dx + dy * dy);
        if (distance >= 1) continue;

        final falloff = (1 - distance) * (1 - distance);
        final keep = 1 - maxOpacity * falloff;
        final pixel = canvas.getPixel(px, py);
        canvas.setPixelRgb(
          px,
          py,
          pixel.r * keep,
          pixel.g * keep,
          pixel.b * keep,
        );
      }
    }
  }
}
