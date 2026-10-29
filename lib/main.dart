/// Uygulamanın giriş noktası.
/// Servisleri oluşturur ve [ShootlyApp]'i servis kapsamıyla birlikte başlatır.
library;

import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/di/app_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final services = await AppServices.create();
  runApp(ShootlyApp(services: services));
}
