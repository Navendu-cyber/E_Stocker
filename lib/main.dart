import 'package:e_stocker/notification/notification_class.dart';
import 'package:e_stocker/routes/App_routes.dart';
import 'package:e_stocker/theme/theme.dart';
import 'package:e_stocker/database/db_models/theme_switching.dart';
import 'package:e_stocker/database/db_functions/main_adapter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveinitialisation();
  await ThemeSwitching.loadTheme();
  await NotificationClass().initNotification();
  runApp(Estocker());
}

class Estocker extends StatelessWidget {
  const Estocker({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: ThemeSwitching.isDArkmode,
        builder: (context, isDArk, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E Stocker',
            theme: isDArk ? AppTheme.darkTheme : AppTheme.lightTheme,
            initialRoute: '/splash',
            routes: AppRoutes.routes,
          );
        });
  }
}
