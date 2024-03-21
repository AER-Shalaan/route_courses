import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/style/app_colors.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/providers/theme_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/Splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  @override

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      checkAutoLogin();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                height: height*0.1,
                width: width*0.5,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(themeProvider.theme==ThemeMode.dark?"assets/images/Routelight.png":"assets/images/Route.png"),fit: BoxFit.fill)
              )
            ),
          ),
          SizedBox(height: height*0.05),
          LoadingAnimationWidget.inkDrop(
            color: themeProvider.theme==ThemeMode.dark?Colors.white:AppColors.primaryColor,
            size: height*0.05,
          )
        ],
      ),
    );
  }
  checkAutoLogin() async {
    MyAuthProvider myAuthProvider = Provider.of<MyAuthProvider>(context, listen: false);
    if(myAuthProvider.isFirebaseUserLoggedIn()){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }else{
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}