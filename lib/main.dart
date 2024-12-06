import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_ecommerce/routes.dart';
import 'package:ui_ecommerce/screens/home/components/home_screen.dart';
import 'package:ui_ecommerce/screens/splash/splash_screen.dart';
import 'package:ui_ecommerce/state_managements/auth_provider.dart';
import 'package:ui_ecommerce/state_managements/cart_provider.dart';
import 'package:ui_ecommerce/state_managements/favorite_provider.dart';
import 'package:ui_ecommerce/state_managements/search_provider.dart';
import 'package:ui_ecommerce/state_managements/theme_provider.dart';
import 'package:ui_ecommerce/theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => CartProvider()),
          ChangeNotifierProvider(create: (context) => FavouriteProvider()),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
        ],
        child: MainApp(isLoggedIn: isLoggedIn));
    }
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) => MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: themeData(theme.isDarkMode),
        darkTheme: ThemeData.dark(),
        initialRoute: isLoggedIn ? HomeScreen.routeName : SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}