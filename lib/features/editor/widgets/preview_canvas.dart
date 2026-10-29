/// Dışa aktarılacak görselin canlı önizlemesi.
/// [ImageComposer] ile aynı oranları kullanır; işleniyor ve hata durumlarını da çizer.
library;

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/canvas_size.dart';
import '../../../core/models/cutout.dart';
import '../../../core/models/export_settings.dart';
import '../editor_controller.dart';

/// Dışa aktarılacak görselin canlı önizlemesi. Asıl görsel
/// ImageComposer ile aynı oranlarla üretilir.
class PreviewCanvas extends StatelessWidget {
  const PreviewCanvas({
    super.key,
    required this.photo,
    required this.settings,
    required this.onRetry,
  });

  static const _maxHeight = 440.0;

  final EditorPhoto photo;
  final ExportSettings settings;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cutout = photo.cutout;
    // "Orijinal" modunda ürün hazır olana kadar kare yer tutucu gösterilir.
    final canvas = cutout != null
        ? settings.canvasFor(cutout)
        : settings.fixedCanvas ??
            const CanvasSize(width: 1, height: 1, fill: ExportSettings.originalFill);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: _maxHeight),
        child: AspectRatio(
          aspectRatio: canvas.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: ShootlyColors.line),
              ),
              color: settings.backdrop.color,
              child: switch (photo.status) {
                PhotoStatus.processing => const _Processing(),
                PhotoStatus.failed => _Failed(
                    message: photo.error ?? 'Fotoğraf işlenemedi.',
                    onRetry: onRetry,
                  ),
                PhotoStatus.ready when cutout != null => _Subject(
                    cutout: cutout,
                    fill: canvas.fill,
                    shadow: settings.shadow,
                  ),
                PhotoStatus.ready => const SizedBox.shrink(),
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Subject extends StatelessWidget {
  const _Subject({
    required this.cutout,
    required this.fill,
    required this.shadow,
  });

  final Cutout cutout;
  final double fill;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: fill,
      heightFactor: fill,
      child: Center(
        child: AspectRatio(
          aspectRatio: cutout.aspectRatio,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (shadow) const _FloorShadow(),
              Positioned.fill(child: Image.file(File(cutout.path))),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloorShadow extends StatelessWidget {
  const _FloorShadow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: -4,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 14,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Processing extends StatelessWidget {
  const _Processing();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: ShootlyColors.ink),
          SizedBox(height: 14),
          Text(
            'Arka plan siliniyor…',
            style: TextStyle(
              color: ShootlyColors.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Failed extends StatelessWidget {
  const _Failed({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, color: ShootlyColors.muted),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ShootlyColors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(minimumSize: const Size(140, 46)),
              child: const Text('Tekrar dene'),
            ),
          ],
        ),
      ),
    );
  }
}
