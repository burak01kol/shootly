/// "Shootly" yazı logosu widget'ı.
/// Uygulama adını kalın, sıkı harflerle ve sonunda bir noktayla çizer.
library;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../config/app_config.dart';

class ShootlyWordmark extends StatelessWidget {
  const ShootlyWordmark({super.key, this.fontSize = 24});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      const TextSpan(
        text: AppConfig.appName,
        children: [
          TextSpan(text: '.', style: TextStyle(color: ShootlyColors.ink)),
        ],
      ),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        color: ShootlyColors.ink,
      ),
    );
  }
}
