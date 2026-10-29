/// Shootly'nin siyah-beyaz, sade ve modern teması.
/// Renk paleti [ShootlyColors]'ta, yazı tipi Plus Jakarta Sans; tema ayarları yalnızca burada yapılır.
library;

import 'package:flutter/material.dart';

/// Uygulamanın siyah-beyaz renk paleti; vurgu rengi bilinçli olarak yok.
/// Ekranlar renkleri buradan ya da temadan alır.
abstract final class ShootlyColors {
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF5F5F7);
  static const ink = Color(0xFF0B0B0F);
  static const muted = Color(0xFF6E6E78);
  static const line = Color(0xFFE6E6EB);
}

abstract final class AppTheme {
  static const fontFamily = 'PlusJakartaSans';

  static const _radius = 18.0;
  static const _buttonHeight = 58.0;

  static ThemeData get light {
    const scheme = ColorScheme.light(
      primary: ShootlyColors.ink,
      onPrimary: Colors.white,
      secondary: ShootlyColors.ink,
      onSecondary: Colors.white,
      surface: ShootlyColors.background,
      onSurface: ShootlyColors.ink,
      onSurfaceVariant: ShootlyColors.muted,
      surfaceContainerHighest: ShootlyColors.surface,
      surfaceContainerHigh: ShootlyColors.surface,
      surfaceContainer: ShootlyColors.surface,
      primaryContainer: ShootlyColors.surface,
      onPrimaryContainer: ShootlyColors.ink,
      tertiaryContainer: ShootlyColors.surface,
      onTertiaryContainer: ShootlyColors.ink,
      outline: ShootlyColors.muted,
      outlineVariant: ShootlyColors.line,
    );
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_radius),
    );
    const buttonText = TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: ShootlyColors.background,
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: ShootlyColors.background,
        foregroundColor: ShootlyColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: ShootlyColors.ink,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(_buttonHeight),
          shape: buttonShape,
          textStyle: buttonText,
          disabledBackgroundColor: ShootlyColors.line,
          disabledForegroundColor: ShootlyColors.muted,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(_buttonHeight),
          shape: buttonShape,
          textStyle: buttonText,
          foregroundColor: ShootlyColors.ink,
          side: const BorderSide(color: ShootlyColors.line, width: 1.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ShootlyColors.ink,
          textStyle: buttonText.copyWith(fontSize: 15),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: ShootlyColors.surface,
        selectedColor: ShootlyColors.ink,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          color: ShootlyColors.ink,
        ),
        checkmarkColor: Colors.white,
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ShootlyColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ShootlyColors.ink, width: 1.5),
        ),
        hintStyle: const TextStyle(color: ShootlyColors.muted),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? ShootlyColors.ink
              : ShootlyColors.line,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: ShootlyColors.ink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentTextStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      dividerTheme: const DividerThemeData(color: ShootlyColors.line),
    );
  }

  /// Başlıklar kalın ve sıkı, gövde metni rahat okunur.
  static TextTheme _textTheme(TextTheme base) {
    TextStyle? tight(TextStyle? style, FontWeight weight, double spacing) =>
        style?.copyWith(fontWeight: weight, letterSpacing: spacing);
    return base
        .copyWith(
          displaySmall: tight(base.displaySmall, FontWeight.w800, -1.2),
          headlineLarge: tight(base.headlineLarge, FontWeight.w800, -1),
          headlineMedium: tight(base.headlineMedium, FontWeight.w800, -0.8),
          headlineSmall: tight(base.headlineSmall, FontWeight.w800, -0.5),
          titleLarge: tight(base.titleLarge, FontWeight.w700, -0.3),
          titleMedium: tight(base.titleMedium, FontWeight.w700, -0.1),
          titleSmall: tight(base.titleSmall, FontWeight.w700, 0),
          labelLarge: tight(base.labelLarge, FontWeight.w700, 0),
        )
        .apply(
          bodyColor: ShootlyColors.ink,
          displayColor: ShootlyColors.ink,
        );
  }
}
