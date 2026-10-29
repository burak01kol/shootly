/// Dışa aktarma ayarları: ölçü (pazaryeri, orijinal ya da özel), zemin rengi ve gölge.
/// Çıktı ölçüsü [ExportSettings.canvasFor], Pro kontrolü [ExportSettings.needsPro] ile tek yerde hesaplanır.
library;

import 'package:flutter/foundation.dart';

import 'backdrop.dart';
import 'canvas_size.dart';
import 'cutout.dart';
import 'marketplace.dart';

/// Dışa aktarılacak görselin nasıl hazırlanacağı.
@immutable
class ExportSettings {
  const ExportSettings({
    this.sizeMode = SizeMode.marketplace,
    this.marketplace = Marketplace.trendyol,
    this.customWidth = 2000,
    this.customHeight = 2000,
    this.backdrop = Backdrop.white,
    this.shadow = false,
  });

  static const originalFill = 0.9;
  static const customFill = 0.85;

  final SizeMode sizeMode;
  final Marketplace marketplace;
  final int customWidth;
  final int customHeight;
  final Backdrop backdrop;
  final bool shadow;

  /// Bu ayarlar Pro abonelik gerektiriyor mu?
  bool get needsPro =>
      !sizeMode.isFree ||
      (sizeMode == SizeMode.marketplace && !marketplace.isFree) ||
      !backdrop.isFree ||
      shadow;

  /// Ürüne bakmadan bilinen tuval; "Orijinal" modunda ürün gerektiği için null.
  CanvasSize? get fixedCanvas => switch (sizeMode) {
        SizeMode.marketplace => CanvasSize(
            width: marketplace.width,
            height: marketplace.height,
            fill: marketplace.fill,
          ),
        SizeMode.custom => CanvasSize(
            width: customWidth,
            height: customHeight,
            fill: customFill,
          ),
        SizeMode.original => null,
      };

  /// Bu ürün için üretilecek tuvalin ölçüsü.
  CanvasSize canvasFor(Cutout cutout) =>
      fixedCanvas ??
      CanvasSize.matching(
        subjectWidth: cutout.width,
        subjectHeight: cutout.height,
        fill: originalFill,
      );

  ExportSettings copyWith({
    SizeMode? sizeMode,
    Marketplace? marketplace,
    int? customWidth,
    int? customHeight,
    Backdrop? backdrop,
    bool? shadow,
  }) {
    return ExportSettings(
      sizeMode: sizeMode ?? this.sizeMode,
      marketplace: marketplace ?? this.marketplace,
      customWidth: customWidth ?? this.customWidth,
      customHeight: customHeight ?? this.customHeight,
      backdrop: backdrop ?? this.backdrop,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ExportSettings &&
      other.sizeMode == sizeMode &&
      other.marketplace == marketplace &&
      other.customWidth == customWidth &&
      other.customHeight == customHeight &&
      other.backdrop == backdrop &&
      other.shadow == shadow;

  @override
  int get hashCode => Object.hash(
        sizeMode,
        marketplace,
        customWidth,
        customHeight,
        backdrop,
        shadow,
      );
}
