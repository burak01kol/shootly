/// Düzenleme ekranının sade ayar paneli.
/// Ölçü (pazaryeri, orijinal ya da özel), zemin rengi ve gölge seçimini yapar; varsayılanlar hazır olduğu için dokunmadan geçilebilir.
library;

import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/models/backdrop.dart';
import '../../../core/models/canvas_size.dart';
import '../../../core/models/export_settings.dart';
import '../../../core/models/marketplace.dart';
import '../../../core/widgets/pro_lock_chip.dart';
import '../../../app/l10n.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({
    super.key,
    required this.settings,
    required this.isPro,
    required this.onChanged,
    required this.onCustomSize,
  });

  final ExportSettings settings;
  final bool isPro;
  final ValueChanged<ExportSettings> onChanged;

  /// "Özel" etiketine dokunulunca çağrılır; ölçü penceresini sayfa açar.
  final VoidCallback onCustomSize;

  @override
  Widget build(BuildContext context) {
    final mode = settings.sizeMode;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(l10n.sectionSize, trailing: _sizeSummary(l10n)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: [
              for (final option in Marketplace.values)
                _sizeChip(
                  label: option.label,
                  selected: mode == SizeMode.marketplace &&
                      option == settings.marketplace,
                  locked: !option.isFree && !isPro,
                  onSelected: () => onChanged(settings.copyWith(
                    sizeMode: SizeMode.marketplace,
                    marketplace: option,
                  )),
                ),
              _sizeChip(
                label: l10n.sizeOriginal,
                selected: mode == SizeMode.original,
                locked: false,
                onSelected: () =>
                    onChanged(settings.copyWith(sizeMode: SizeMode.original)),
              ),
              _sizeChip(
                label: l10n.sizeCustom,
                selected: mode == SizeMode.custom,
                locked: !isPro,
                onSelected: onCustomSize,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle(l10n.sectionBackdrop),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final option in Backdrop.values)
              _Swatch(
                backdrop: option,
                selected: option == settings.backdrop,
                locked: !option.isFree && !isPro,
                onTap: () => onChanged(settings.copyWith(backdrop: option)),
              ),
          ],
        ),
        const SizedBox(height: 20),
        _ShadowToggle(
          value: settings.shadow,
          locked: !isPro,
          onChanged: (value) => onChanged(settings.copyWith(shadow: value)),
        ),
      ],
    );
  }

  Widget _sizeChip({
    required String label,
    required bool selected,
    required bool locked,
    required VoidCallback onSelected,
  }) {
    return _ChipSlot(
      selected: selected,
      child: ProLockChip(
        label: label,
        selected: selected,
        locked: locked,
        onSelected: onSelected,
      ),
    );
  }

  String _sizeSummary(AppLocalizations l10n) => switch (settings.sizeMode) {
        SizeMode.original => l10n.sizeMatchesProduct,
        _ => '${settings.fixedCanvas}',
      };
}

/// Yatay listedeki bir ölçü etiketi; seçili olan görünür alana kaydırılır.
class _ChipSlot extends StatefulWidget {
  const _ChipSlot({required this.selected, required this.child});

  final bool selected;
  final Widget child;

  @override
  State<_ChipSlot> createState() => _ChipSlotState();
}

class _ChipSlotState extends State<_ChipSlot> {
  @override
  void initState() {
    super.initState();
    if (widget.selected) _revealAfterFrame(animate: false);
  }

  @override
  void didUpdateWidget(_ChipSlot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected && !oldWidget.selected) _revealAfterFrame(animate: true);
  }

  void _revealAfterFrame({required bool animate}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chip = context.findRenderObject();
      if (!mounted || chip == null) return;
      // Yalnızca yatay etiket listesi kayar; sayfanın kendisi yerinde kalır.
      Scrollable.of(context).position.ensureVisible(
            chip,
            alignment: 0.5,
            duration:
                animate ? const Duration(milliseconds: 250) : Duration.zero,
            curve: Curves.easeOutCubic,
          );
    });
  }

  @override
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.only(right: 8), child: widget.child);
}

class _SectionTitle extends StatelessWidget {
  /// [text] dilin büyük harf kuralı için (Türkçede i → İ) çeviride hazır büyük harfle gelir.
  const _SectionTitle(this.text, {this.trailing});

  final String text;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: ShootlyColors.muted,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(text, style: style),
          const Spacer(),
          if (trailing != null)
            Text(trailing!, style: style.copyWith(letterSpacing: 0)),
        ],
      ),
    );
  }
}

class _ShadowToggle extends StatelessWidget {
  const _ShadowToggle({
    required this.value,
    required this.locked,
    required this.onChanged,
  });

  final bool value;
  final bool locked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
      decoration: BoxDecoration(
        color: ShootlyColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.blur_on_rounded, color: ShootlyColors.ink),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.l10n.floorShadow,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          if (locked)
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(
                Icons.lock_outline_rounded,
                size: 16,
                color: ShootlyColors.muted,
              ),
            ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

String _backdropName(AppLocalizations l10n, Backdrop backdrop) =>
    switch (backdrop) {
      Backdrop.white => l10n.backdropWhite,
      Backdrop.lightGrey => l10n.backdropLightGrey,
      Backdrop.cream => l10n.backdropCream,
      Backdrop.sky => l10n.backdropSky,
      Backdrop.blush => l10n.backdropBlush,
      Backdrop.black => l10n.backdropBlack,
    };

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.backdrop,
    required this.selected,
    required this.locked,
    required this.onTap,
  });

  static const _size = 44.0;

  final Backdrop backdrop;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isLight = backdrop.color.computeLuminance() > 0.5;
    final iconColor = isLight ? ShootlyColors.ink : Colors.white;
    final name = _backdropName(context.l10n, backdrop);
    return Semantics(
      button: true,
      selected: selected,
      label: locked ? '$name (Pro)' : name,
      child: InkResponse(
        onTap: onTap,
        radius: _size / 2 + 4,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: _size,
          height: _size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? ShootlyColors.ink : Colors.transparent,
              width: 2,
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backdrop.color,
              shape: BoxShape.circle,
              border: Border.all(color: ShootlyColors.line),
            ),
            child: selected
                ? Icon(Icons.check_rounded, size: 18, color: iconColor)
                : locked
                    ? Icon(Icons.lock_outline_rounded, size: 14, color: iconColor)
                    : null,
          ),
        ),
      ),
    );
  }
}
