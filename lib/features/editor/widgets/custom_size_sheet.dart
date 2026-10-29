/// "Özel ölçü" alt penceresi: hazır oranlardan birine dokunarak ya da
/// genişlik × yükseklik yazarak çıktı ölçüsünü belirler. Sonucu [CustomSize] olarak döner.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme.dart';
import '../../../core/models/canvas_size.dart';

/// Kullanıcının seçtiği özel ölçü.
typedef CustomSize = ({int width, int height});

/// Pencereyi açar; vazgeçilirse null döner.
Future<CustomSize?> showCustomSizeSheet(
  BuildContext context, {
  required CustomSize initial,
}) {
  return showModalBottomSheet<CustomSize>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: ShootlyColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => CustomSizeSheet(initial: initial),
  );
}

class CustomSizeSheet extends StatefulWidget {
  const CustomSizeSheet({super.key, required this.initial});

  final CustomSize initial;

  @override
  State<CustomSizeSheet> createState() => _CustomSizeSheetState();
}

class _CustomSizeSheetState extends State<CustomSizeSheet> {
  static const _presets = [
    (label: 'Kare', ratio: '1:1', width: 2000, height: 2000),
    (label: 'Dikey', ratio: '4:5', width: 1600, height: 2000),
    (label: 'Portre', ratio: '3:4', width: 1500, height: 2000),
    (label: 'Hikâye', ratio: '9:16', width: 1080, height: 1920),
    (label: 'Yatay', ratio: '16:9', width: 1920, height: 1080),
  ];

  late final _widthController =
      TextEditingController(text: '${widget.initial.width}');
  late final _heightController =
      TextEditingController(text: '${widget.initial.height}');

  int? get _width => int.tryParse(_widthController.text);
  int? get _height => int.tryParse(_heightController.text);
  bool get _isValid =>
      CanvasSize.isValidSide(_width) && CanvasSize.isValidSide(_height);

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _applyPreset(int width, int height) {
    setState(() {
      _widthController.text = '$width';
      _heightController.text = '$height';
    });
  }

  void _submit() {
    if (!_isValid) return;
    Navigator.of(context).pop((width: _width!, height: _height!));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 24 + keyboard),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Özel ölçü', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(
            'Hazır bir oran seç ya da ölçüyü kendin yaz.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: ShootlyColors.muted,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final preset in _presets)
                _PresetTile(
                  label: preset.label,
                  ratio: preset.ratio,
                  selected:
                      _width == preset.width && _height == preset.height,
                  onTap: () => _applyPreset(preset.width, preset.height),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _SideField(
                  label: 'Genişlik',
                  controller: _widthController,
                  onChanged: () => setState(() {}),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '×',
                  style: TextStyle(fontSize: 22, color: ShootlyColors.muted),
                ),
              ),
              Expanded(
                child: _SideField(
                  label: 'Yükseklik',
                  controller: _heightController,
                  onChanged: () => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Her kenar ${CanvasSize.minSide}–${CanvasSize.maxSide} piksel arasında olmalı.',
            style: TextStyle(
              fontSize: 13,
              color: _isValid ? ShootlyColors.muted : theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _isValid ? _submit : null,
            child: const Text('Uygula'),
          ),
        ],
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({
    required this.label,
    required this.ratio,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String ratio;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : ShootlyColors.ink;
    return Material(
      color: selected ? ShootlyColors.ink : ShootlyColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w700, color: foreground),
              ),
              Text(
                ratio,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white70 : ShootlyColors.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideField extends StatelessWidget {
  const _SideField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
      ],
      onChanged: (_) => onChanged(),
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      decoration: InputDecoration(labelText: label, suffixText: 'px'),
    );
  }
}
