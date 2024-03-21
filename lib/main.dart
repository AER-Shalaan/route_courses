import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/layout/login/login_screen.dart';
import 'package:route_courses/shared/providers/auth_provider.dart';
import 'package:route_courses/shared/providers/theme_provider.dart';
import 'package:route_courses/style/theme.dart';
import 'firebase_options.dart';
import 'layout/home/home_screen.dart';
import 'layout/sign_up/sign_up.dart';
import 'layout/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider<ThemeProvider>(create:(context) => ThemeProvider()..initialize()),
        ChangeNotifierProvider<MyAuthProvider>(create:(context) => MyAuthProvider()),
        ],
          child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Route Courses',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.theme,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName:(_)=>Splash(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        SignUp.routeName:(_)=>SignUp(),

      },
    );
  }
}