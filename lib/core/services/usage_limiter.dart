/// Ücretsiz plandaki günlük dışa aktarma hakkını sayan servis.
/// Sayaç `SharedPreferences`'ta saklanır ve her gün gece yarısı sıfırlanır.
library;

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

/// Ücretsiz plandaki günlük dışa aktarma hakkını takip eder.
/// Sayaç her gün gece yarısı sıfırlanır.
class UsageLimiter extends ChangeNotifier {
  UsageLimiter(
    this._prefs, {
    this.dailyLimit = AppConfig.freeDailyExports,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  static const _dayKey = 'usage.day';
  static const _countKey = 'usage.count';

  final SharedPreferences _prefs;
  final DateTime Function() _clock;
  final int dailyLimit;

  int get remainingToday {
    if (_prefs.getString(_dayKey) != _todayKey) return dailyLimit;
    final used = _prefs.getInt(_countKey) ?? 0;
    return math.max(0, dailyLimit - used);
  }

  bool get canExport => remainingToday > 0;

  Future<void> recordExport() async {
    final used = dailyLimit - remainingToday + 1;
    await _prefs.setString(_dayKey, _todayKey);
    await _prefs.setInt(_countKey, used);
    notifyListeners();
  }

  String get _todayKey {
    final now = _clock();
    return '${now.year}-${now.month}-${now.day}';
  }
}
