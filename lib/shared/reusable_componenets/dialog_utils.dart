import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/style/app_colors.dart';

import '../providers/theme_provider.dart';

class DialogUtils{


  static void showLoadingDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: themeProvider.theme==ThemeMode.dark?AppColors.textFiledFilledDarkColor:Colors.white,
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: AppColors.primaryColor),
                const SizedBox(width: 15,),
                Text("Loading...",style: Theme.of(context).textTheme.titleLarge)
              ],
            ),
          ),
        ),
      );
    });
  }


  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }



  static void showMessage({required BuildContext context ,required String message ,
    String? positiveTitleButton,
    String? negativeTitleButton,
    void Function()? positiveButtonPress,
    void Function()? negativeButtonPress,
  }){
    showDialog(context: context, builder: (context){
      ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: themeProvider.theme==ThemeMode.dark?AppColors.textFiledFilledDarkColor:Colors.white,
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10 , right: 10),
                  child: Text(message,style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(positiveTitleButton!=null)
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: themeProvider.theme==ThemeMode.dark? Colors.white:AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        onPressed: positiveButtonPress,
                        child: Text(positiveTitleButton,style: TextStyle(color:themeProvider.theme==ThemeMode.dark?Colors.black:Colors.white)),
                    ),
                    if(negativeTitleButton!=null)
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ),
                        onPressed: negativeButtonPress,
                        child: Text(negativeTitleButton,style: TextStyle(color:Colors.white)),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}