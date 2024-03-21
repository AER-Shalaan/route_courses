import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/layout/sign_up/sign_up.dart';
import 'package:route_courses/shared/reusable_componenets/custom_form_field.dart';
import 'package:route_courses/style/app_colors.dart';
import '../../shared/firebase/firebaseautherrorcodes.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/providers/theme_provider.dart';
import '../../shared/reusable_componenets/dialog_utils.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/Login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String emailRegExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset:false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: width*0.05,left: width*0.05),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(image: AssetImage( themeProvider.theme== ThemeMode.light?"assets/images/Route.png":"assets/images/Routelight.png")),
                      IconButton(onPressed: (){
                        themeProvider.changeTheme(themeProvider.theme == ThemeMode.dark?ThemeMode.light:ThemeMode.dark);
                        }, icon: SvgPicture.asset(
                          themeProvider.theme== ThemeMode.light?"assets/svg/Vector.svg":"assets/svg/mingcute_sun-fill.svg"))
                    ],
                  ),
                  SizedBox(height: height*0.1),
                  Text("Hi, Welcome Back!",style: Theme.of(context).textTheme.headlineLarge,),
                  Text("Hello again, you’ve been missed!",style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: height*0.05),
                  Text("Email",style: Theme.of(context).textTheme.labelMedium),
                  SizedBox(height: height*0.01),
                  CustomFormField(
                      hintText: "Enter your email",
                      controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return "this field can't be empty";
                      }
                      if(!RegExp(emailRegExp).hasMatch(value)){
                        return"Email is not valid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height*0.03),
                  Text("Password",style: Theme.of(context).textTheme.labelMedium),
                  SizedBox(height: height*0.01),
                  CustomFormField(
                      hintText: "Please Enter Your Password",
                    keyboard: TextInputType.visiblePassword,
                    obscure: isObscure ,
                    controller: passController,
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isObscure = !isObscure;
                          });},
                        icon: Icon(
                          isObscure?Icons.visibility_off:Icons.visibility,
                          size: 24,
                        )
                    ),
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return "this field can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height*0.06),
                  SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                        login();
                        }, child: Text("Login",style:TextStyle(color:themeProvider.theme== ThemeMode.light?Colors.white:Colors.black,fontSize: 17, fontWeight: FontWeight.w600)))),
                  SizedBox(height: height*0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account ?  ",style: Theme.of(context).textTheme.titleMedium),
                      InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, SignUp.routeName);
                          },
                          child: const Text("Sign Up", style: TextStyle(color: AppColors.primaryColor,fontSize: 14,fontWeight: FontWeight.w600),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void login() async{
    MyAuthProvider provider = Provider.of<MyAuthProvider>(context ,listen: false);
    if(formKey.currentState?.validate()??false){
      DialogUtils.showLoadingDialog(context);
      try {
        UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim()
        );
        provider.setUsers(credential.user);
        DialogUtils.hideLoading(context);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      }
      on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == FirebaseAuthErrorCodes.userNotFound) {
          DialogUtils.showMessage(context: context, message: 'No user found for that email',
              positiveTitleButton: "OK",
              positiveButtonPress: (){
                DialogUtils.hideLoading(context);
              });
        } else if (e.code == FirebaseAuthErrorCodes.wrongPassword) {
          DialogUtils.showMessage(context: context, message: 'Wrong password',
              positiveTitleButton: "OK",
              positiveButtonPress: (){
                DialogUtils.hideLoading(context);
              });
        }
      } catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message:e.toString(),
            positiveTitleButton: "ok",
            positiveButtonPress: (){
              DialogUtils.hideLoading(context);
            }
        );
      }
    }
  }
}
