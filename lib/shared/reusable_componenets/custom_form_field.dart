import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/style/app_colors.dart';

import '../providers/theme_provider.dart';
typedef FieldValidation = String? Function(String?)?;
class CustomFormField extends StatelessWidget {
  String hintText;
  TextInputType? keyboard;
  bool obscure;
  Widget? suffixIcon;
  FieldValidation validator;
  TextEditingController? controller;
  CustomFormField({super.key,required this.hintText,this.keyboard,this.obscure = false,this.suffixIcon , this.validator,required this.controller});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffixIconColor: themeProvider.theme == ThemeMode.dark?AppColors.primaryColor:Colors.black,
          hintText: hintText ,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          filled: true,
          fillColor: themeProvider.theme == ThemeMode.dark?AppColors.textFiledFilledDarkColor:Colors.white,
          enabledBorder:  OutlineInputBorder(borderSide: const BorderSide(color: AppColors.textFiledBorderColor,width: 2),borderRadius: BorderRadius.circular(10)),
          disabledBorder:  OutlineInputBorder(borderSide: const BorderSide(color: AppColors.textFiledBorderColor,width: 2),borderRadius: BorderRadius.circular(10)),
          focusedBorder:  OutlineInputBorder(borderSide: const BorderSide(color: AppColors.textFiledBorderColor,width: 2),borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red,width: 2),borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder:OutlineInputBorder(borderSide: const BorderSide(color: Colors.red,width: 2),borderRadius: BorderRadius.circular(10))
      ),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
