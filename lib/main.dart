import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:helia_frontend/app/bindings/main_binding.dart';
import 'package:helia_frontend/app/routes/app_pages.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:helia_frontend/app/themes/app_theme.dart';

void main() {
  initializeDateFormatting().then((_) => runApp);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appLightTheme,
      //darkThjajajajjajeme: ,
      //themeMode: ThemeMode.system,

      getPages: AppPages.routes,
      initialRoute: Routes.home,
      initialBinding: MainBinding(),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
