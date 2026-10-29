/// Dışa aktarma sonuç ekranı.
/// Galeriye kaydetme sonucunu gösterir (izin yoksa ayarlara yönlendirir); paylaşma ve tek dokunuşla yeni çekim sunar.
library;

import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/config/app_config.dart';
import '../../core/di/app_services.dart';
import '../../core/services/export_service.dart';
import '../../core/widgets/permission_sheet.dart';

class ExportResultPage extends StatefulWidget {
  const ExportResultPage({
    super.key,
    required this.files,
    required this.saveResult,
  });

  final List<File> files;

  /// Editörün galeriye kaydetme denemesinin sonucu.
  final GallerySaveResult saveResult;

  @override
  State<ExportResultPage> createState() => _ExportResultPageState();
}

class _ExportResultPageState extends State<ExportResultPage> {
  late GallerySaveResult _result = widget.saveResult;
  bool _saving = false;

  bool get _saved => _result == GallerySaveResult.saved;

  Future<void> _retrySave() async {
    final exporter = ServicesScope.of(context).exporter;
    setState(() => _saving = true);
    final result = await exporter.saveToGallery(widget.files);
    if (!mounted) return;
    setState(() {
      _result = result;
      _saving = false;
    });
    if (result == GallerySaveResult.denied) {
      await showPermissionSheet(context, AppPermission.saveToGallery);
    }
  }

  String _statusText(int count) => switch (_result) {
        GallerySaveResult.saved =>
          '$count görsel galerinde, ${AppConfig.galleryAlbum} albümünde.',
        GallerySaveResult.denied =>
          '$count görsel hazır. Galeriye kaydetmek için izin gerekiyor; '
              'istersen "Paylaş" ile de gönderebilirsin.',
        GallerySaveResult.failed =>
          '$count görsel hazır, ancak galeriye kaydedilemedi.',
      };

  Future<void> _share() => ServicesScope.of(context).exporter.share(widget.files);

  void _newShoot() =>
      Navigator.of(context).popUntil((route) => route.isFirst);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = widget.files.length;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Kapat',
            onPressed: _newShoot,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusBadge(saved: _saved),
                  const SizedBox(height: 18),
                  Text('Hazır!', style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 6),
                  Text(
                    _statusText(count),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: ShootlyColors.muted,
                    ),
                  ),
                  if (!_saved) ...[
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _saving ? null : _retrySave,
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(
                        _result == GallerySaveResult.denied
                            ? 'İzin ver ve kaydet'
                            : 'Tekrar kaydet',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: count,
              itemBuilder: (context, index) =>
                  _ResultTile(file: widget.files[index]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _share,
                  icon: const Icon(Icons.ios_share_rounded),
                  label: const Text('Paylaş'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _newShoot,
                  icon: const Icon(Icons.photo_camera_rounded),
                  label: const Text('Yeni çekim'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.saved});

  final bool saved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: saved ? ShootlyColors.ink : ShootlyColors.surface,
      ),
      child: Icon(
        saved ? Icons.check_rounded : Icons.download_done_rounded,
        color: saved ? Colors.white : ShootlyColors.ink,
        size: 30,
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    final name = file.uri.pathSegments.last;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ShootlyColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: ShootlyColors.line),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.file(file, fit: BoxFit.contain, cacheWidth: 600),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ShootlyColors.muted,
          ),
        ),
      ],
    );
  }
}
