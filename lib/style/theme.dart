import 'package:flutter/material.dart';
import 'package:route_courses/style/app_colors.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
      useMaterial3: false,
      textTheme: const TextTheme(
      headlineLarge: TextStyle(
          color: AppColors.blackTitleColor,
          fontSize: 25,
          fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: AppColors.grayTitleColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: AppColors.blackTitleColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: TextStyle(
        color: AppColors.blackTitleColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: AppColors.blackTitleColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: TextStyle(
        color: AppColors.blackTitleColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: AppColors.grayTitleColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
        bodySmall: TextStyle(
          color: AppColors.blackTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelSmall:TextStyle(
          color: AppColors.textFiledHitTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        displaySmall: TextStyle(
          color: AppColors.blackTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.solid
        )
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(AppColors.primaryColor))),

    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
      primaryContainer: AppColors.whiteTitleColor

    )
  );



  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundDarkColor,
      useMaterial3: false,

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.whiteTitleColor,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.grayTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: AppColors.whiteTitleColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.whiteTitleColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        displayLarge: TextStyle(
          color: AppColors.grayTitleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        labelLarge:TextStyle(
          color: AppColors.whiteTitleColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: TextStyle(
          color: AppColors.grayTitleColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
          bodyLarge: TextStyle(
            color: AppColors.whiteTitleColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            color: AppColors.grayTitleColor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: AppColors.whiteTitleColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          labelSmall:TextStyle(
            color: AppColors.textFiledHitTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          displaySmall: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid
          )


      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(AppColors.whiteTitleColor))),

      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primaryContainer: AppColors.grayTitleColor

      )
  );
}