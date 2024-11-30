import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/auth/screens/auth_screen.dart';
import 'package:my_amazon_app/router.dart';
import 'package:my_amazon_app/providers/user_provider.dart';
import 'package:my_amazon_app/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(prefs),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'My Amazon',
          locale: languageProvider.currentLocale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: GlobalVar.secondaryColor,
            ),
            scaffoldBackgroundColor: GlobalVar.backgroundColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          onGenerateRoute: (settings) => generateRoute(settings),
          home: const AuthScreen(),
        );
      },
    );
  }
}
