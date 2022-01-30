

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:incidence_front/controller/controller.dart';
import 'package:incidence_front/modules/login/sing_in.dart';
import 'package:incidence_front/modules/page/onboarding_page.dart';
import 'package:incidence_front/shared/styles/theme.dart';
import 'package:incidence_front/shared/styles/theme_service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageController()),
      ],
      child: EasyLocalization(
        supportedLocales: [
          Locale('fr', 'FR'),
          Locale('ar', 'MA')
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('fr', 'FR'),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale('fr', 'FR'),
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: ThemeService().theme,
          home: SignIn(),
      ),
    ));
  }
}
