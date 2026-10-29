/// Ayar panellerinde kullanılan seçilebilir etiket widget'ı.
/// Seçenek Pro gerektiriyorsa üzerinde kilit simgesi gösterir.
library;

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Seçilebilir etiket. Pro gerektiriyorsa kilit simgesi gösterir.
class ProLockChip extends StatelessWidget {
  const ProLockChip({
    super.key,
    required this.label,
    required this.selected,
    required this.locked,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final bool locked;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? Colors.white : ShootlyColors.ink;
    return ChoiceChip(
      label: Text(label),
      labelStyle: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontWeight: FontWeight.w600,
        color: foreground,
      ),
      selected: selected,
      avatar: locked
          ? Icon(Icons.lock_outline_rounded, size: 16, color: foreground)
          : null,
      onSelected: (_) => onSelected(),
    );
  }
}
