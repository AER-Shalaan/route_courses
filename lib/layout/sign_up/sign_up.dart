import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/layout/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/firebase/firebaseautherrorcodes.dart';
import '../../shared/providers/theme_provider.dart';
import '../../shared/reusable_componenets/custom_form_field.dart';
import '../../shared/reusable_componenets/dialog_utils.dart';
import '../../style/app_colors.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "/SignUp";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                  Text("Create an account",style: Theme.of(context).textTheme.headlineLarge,),
                  Text("Connect with your friends today!",style: Theme.of(context).textTheme.titleMedium),
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
                      if(value.length<8){
                        return "your password can't be less than 8 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height*0.06),
                  SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(onPressed: (){
                          createNewUser();
                        }, child: Text("Sign Up",style:TextStyle(color:themeProvider.theme== ThemeMode.light?Colors.white:Colors.black,fontSize: 17, fontWeight: FontWeight.w600)))),
                  SizedBox(height: height*0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?  ",style: Theme.of(context).textTheme.titleMedium),
                      InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          },
                          child: const Text("Login", style: TextStyle(color: AppColors.primaryColor,fontSize: 14,fontWeight: FontWeight.w600),))
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
  void createNewUser() async{
    if(formKey.currentState?.validate()??false){
      DialogUtils.showLoadingDialog(context);
      try{
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim()
        );
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context,
            message: " Hi,Welcome\nyour id: ${credential.user?.uid}\nGoing to Login....",
            positiveTitleButton: "OK",
            positiveButtonPress:(){
              DialogUtils.hideLoading(context);
              Navigator.pushReplacementNamed(context,LoginScreen.routeName);
            }

        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == FirebaseAuthErrorCodes.weakPassword) {
          DialogUtils.showMessage(context: context, message: 'The password provided is too weak',
              positiveTitleButton: "ok",
              positiveButtonPress: (){
                DialogUtils.hideLoading(context);
              }
          );
        } else if (e.code == FirebaseAuthErrorCodes.emailAlreadyInUse) {
          DialogUtils.showMessage(context: context, message: 'The account already exists for that email',
              positiveTitleButton: "ok",
              positiveButtonPress: (){
                DialogUtils.hideLoading(context);
              }
          );

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
