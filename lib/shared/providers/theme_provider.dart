import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier{
  ThemeMode theme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme)async{
    if(theme == newTheme) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(newTheme == ThemeMode.dark){
      prefs.setBool("Theme", true);
    }else{
      prefs.setBool("Theme", false);
    }
    theme = newTheme;
    notifyListeners();
  }
  initialize() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    theme=prefs.getBool("Theme")==true?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
}