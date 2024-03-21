import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:route_courses/layout/home/widgets/bestSelling_courses.dart';
import 'package:route_courses/layout/home/widgets/featured_courses.dart';
import 'package:route_courses/shared/firebase/firestore_helper.dart';
import '../../shared/model/course.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/providers/theme_provider.dart';
import '../../shared/reusable_componenets/dialog_utils.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName ="/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    MyAuthProvider myAuthProvider = Provider.of<MyAuthProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset:false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: width*0.01),
                      Image.asset(themeProvider.theme==ThemeMode.dark?"assets/images/miniRoutelight.png":"assets/images/miniRoute.png"),
                      SizedBox(width: width*0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welocme to Route",style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: height*0.01),
                          Text("Enjoy our courses",style: Theme.of(context).textTheme.displayLarge)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        themeProvider.changeTheme(themeProvider.theme == ThemeMode.dark?ThemeMode.light:ThemeMode.dark);
                        }, icon: SvgPicture.asset(
                          themeProvider.theme== ThemeMode.light?"assets/svg/Vector.svg":"assets/svg/mingcute_sun-fill.svg")),
                      IconButton(onPressed: ()async{
                        DialogUtils.showLoadingDialog(context);
                        await myAuthProvider.signOut();
                        DialogUtils.hideLoading(context);
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        }, icon: SvgPicture.asset(
                          themeProvider.theme== ThemeMode.light?"assets/svg/blackSignOut.svg":"assets/svg/SignOut.svg")
                      )
                    ],
                  )

                ],
              ),
            ),
            SizedBox(height: height*0.04),
            Padding(
              padding:EdgeInsets.all(height*0.02),
              child: Row(children: [Text("Featured ",style: Theme.of(context).textTheme.labelLarge),Text("Courses",style: Theme.of(context).textTheme.displayMedium)],),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.transparent,
              height: height*0.31,
              child: FutureBuilder(
                  future: FireStoreHelper.getAllCourses(),
                  builder: (context , snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator.adaptive());
                }if(snapshot.hasError){
                  return Column(
                    children: [
                      Text("Something went wrong ${snapshot.error}"),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red
                            ),
                            onPressed: (){
                          myAuthProvider.signOut();
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          }, child: Text("LogOut and try again ...")),
                      )
                    ],
                  );
                }
                List<Course> courses = snapshot.data??[];
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => FeatureCourses(course: courses[index]),
                    separatorBuilder:(context, index) => SizedBox(width: width*0.04),
                    itemCount: courses.length);

              }),
            ),
            SizedBox(height: height*0.06),
            Padding(
              padding:EdgeInsets.all(height*0.02),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                  ,children: [
                Row(
                  children: [
                    Text("Best Selling ",style: Theme.of(context).textTheme.labelLarge),Text("Courses",style: Theme.of(context).textTheme.displayMedium)
                  ],
                ),
                Text("view All",style: Theme.of(context).textTheme.displaySmall)
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.transparent,
              height: height*0.3,
              child: FutureBuilder(
                  future: FireStoreHelper.getBestSellingCourses(),
                  builder: (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator.adaptive());
                    }if(snapshot.hasError){
                      return Column(
                        children: [
                          Text("Something went wrong ${snapshot.error}"),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red
                                ),
                                onPressed: (){
                                  myAuthProvider.signOut();
                                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                                }, child: Text("LogOut and try again ...")),
                          )
                        ],
                      );
                    }
                    List<Course> courses = snapshot.data??[];
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => BestSellingCourses(course: courses[index]),
                        separatorBuilder:(context, index) => SizedBox(height: height*0.02),
                        itemCount: courses.length);

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
