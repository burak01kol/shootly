/// Düzenleme ekranı: önizleme, fotoğraf şeridi ve sade ayarlar.
/// Son kullanılan ayarlarla açılır; tek "Hazırla ve kaydet" butonu görselleri üretip galeriye kaydeder.
library;

import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/di/app_services.dart';
import '../../core/models/canvas_size.dart';
import '../../core/models/export_settings.dart';
import '../export/export_result_page.dart';
import 'editor_controller.dart';
import 'widgets/custom_size_sheet.dart';
import 'widgets/photo_strip.dart';
import 'widgets/preview_canvas.dart';
import 'widgets/settings_panel.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key, required this.sourcePaths});

  final List<String> sourcePaths;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late final EditorController _controller;
  final _barcodeController = TextEditingController();
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    final services = ServicesScope.of(context);
    _controller = EditorController(
      remover: services.remover,
      sourcePaths: widget.sourcePaths,
      initialSettings: _startingSettings(services),
    );
    unawaited(_controller.processAll());
  }

  /// Son ayarlar; Pro bittiyse Pro'ya ait ayarlar yerine varsayılan kullanılır.
  static ExportSettings _startingSettings(AppServices services) {
    final saved = services.preferences.lastExportSettings;
    return saved.needsPro && !services.subscription.isPro
        ? const ExportSettings()
        : saved;
  }

  @override
  void dispose() {
    _controller.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  /// Pro gerektiren bir ayar seçilirse önce paywall gösterilir.
  Future<void> _applySettings(ExportSettings next) async {
    final services = ServicesScope.of(context);
    if (next.needsPro && !services.subscription.isPro) {
      final becamePro = await services.subscription.showPaywall();
      if (!becamePro) return;
    }
    _controller.updateSettings(next);
    unawaited(services.preferences.saveExportSettings(next));
  }

  /// Özel ölçü Pro'dur: önce paywall, sonra ölçü penceresi.
  Future<void> _pickCustomSize() async {
    final subscription = ServicesScope.of(context).subscription;
    if (!subscription.isPro && !await subscription.showPaywall()) return;
    if (!mounted) return;

    final current = _controller.settings;
    final size = await showCustomSizeSheet(
      context,
      initial: (width: current.customWidth, height: current.customHeight),
    );
    if (size == null) return;
    await _applySettings(current.copyWith(
      sizeMode: SizeMode.custom,
      customWidth: size.width,
      customHeight: size.height,
    ));
  }

  /// Tek tuş: görselleri üretir, galeriye kaydeder ve sonuç ekranını açar.
  Future<void> _exportAndSave() async {
    final services = ServicesScope.of(context);
    if (!services.subscription.isPro && !services.usage.canExport) {
      final becamePro = await services.subscription.showPaywall();
      if (!becamePro) return;
    }

    setState(() => _exporting = true);
    try {
      final files = await services.exporter.export(
        cutouts: _controller.readyCutouts,
        settings: _controller.settings,
        baseName: _barcodeController.text,
      );
      if (!services.subscription.isPro) await services.usage.recordExport();
      final saveResult = await services.exporter.saveToGallery(files);
      if (!mounted) return;
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              ExportResultPage(files: files, saveResult: saveResult),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Görseller hazırlanamadı. Tekrar dene.')),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final subscription = ServicesScope.of(context).subscription;
    return ListenableBuilder(
      listenable: Listenable.merge([_controller, subscription]),
      builder: (context, _) {
        final readyCount = _controller.readyCutouts.length;
        final canExport =
            readyCount > 0 && !_controller.isProcessing && !_exporting;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _controller.photos.length > 1
                  ? '${_controller.photos.length} fotoğraf'
                  : 'Önizleme',
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            children: [
              PreviewCanvas(
                photo: _controller.selected,
                settings: _controller.settings,
                onRetry: () => _controller.retry(_controller.selectedIndex),
              ),
              if (_controller.photos.length > 1) ...[
                const SizedBox(height: 14),
                PhotoStrip(
                  photos: _controller.photos,
                  selectedIndex: _controller.selectedIndex,
                  onSelect: _controller.select,
                ),
              ],
              const SizedBox(height: 24),
              SettingsPanel(
                settings: _controller.settings,
                isPro: subscription.isPro,
                onChanged: _applySettings,
                onCustomSize: _pickCustomSize,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _barcodeController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Barkod veya ürün kodu (isteğe bağlı)',
                  prefixIcon: Icon(Icons.qr_code_2_rounded),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: FilledButton.icon(
                onPressed: canExport ? _exportAndSave : null,
                icon: _exporting || _controller.isProcessing
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.check_rounded),
                label: Text(_buttonLabel(readyCount)),
              ),
            ),
          ),
        );
      },
    );
  }

  String _buttonLabel(int readyCount) {
    if (_controller.isProcessing) return 'Arka plan siliniyor…';
    if (_exporting) return 'Hazırlanıyor…';
    if (readyCount == 0) return 'Hazır fotoğraf yok';
    return readyCount > 1
        ? 'Hazırla ve kaydet ($readyCount)'
        : 'Hazırla ve kaydet';
  }
}
