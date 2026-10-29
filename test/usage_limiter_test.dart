/// [UsageLimiter] için birim testleri: günlük hak düşümü,
/// sıfırın altına inmeme ve ertesi gün yenilenme.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitrin/core/services/usage_limiter.dart';

void main() {
  late SharedPreferences prefs;
  var now = DateTime(2026, 10, 29, 10);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    now = DateTime(2026, 10, 29, 10);
  });

  UsageLimiter limiter() => UsageLimiter(prefs, dailyLimit: 3, clock: () => now);

  test('gün başında tüm haklar mevcut', () {
    expect(limiter().remainingToday, 3);
  });

  test('her dışa aktarma bir hak düşer, sıfırın altına inmez', () async {
    final usage = limiter();
    for (var i = 0; i < 4; i++) {
      await usage.recordExport();
    }
    expect(usage.remainingToday, 0);
    expect(usage.canExport, isFalse);
  });

  test('ertesi gün haklar yenilenir', () async {
    final usage = limiter();
    await usage.recordExport();
    await usage.recordExport();
    expect(usage.remainingToday, 1);

    now = DateTime(2026, 10, 30, 0, 1);
    expect(usage.remainingToday, 3);
  });
}
