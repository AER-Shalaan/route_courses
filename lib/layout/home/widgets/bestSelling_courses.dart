import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/model/course.dart';
import '../../../shared/providers/theme_provider.dart';
import '../../../style/app_colors.dart';

class BestSellingCourses extends StatelessWidget {
  Course course;

  BestSellingCourses({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height*0.10,
      margin: EdgeInsets.symmetric(horizontal: width*0.02),
      decoration: BoxDecoration(color: themeProvider.theme == ThemeMode.dark?AppColors.homeContainerDarkColor:Colors.white,borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(width*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Expanded(
             flex: 3,
             child: Row(
               children: [
                 Expanded(
                   flex: 2,
                   child: Container(
                     height:double.infinity,
                     width: width*0.2,
                     decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),
                         image:DecorationImage(image: NetworkImage(course.image??"https://techsouthafrica.co.za/wp-content/uploads/2023/01/No-Image.jpg"),fit: BoxFit.fill)
                     ),
                   ),
                 ),
                 SizedBox(width: width*0.04),
                 Expanded(
                   flex: 3,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(course.title??"",style: Theme.of(context).textTheme.bodyLarge),
                       SizedBox(height: height*0.006),
                       Text("${course.students} Students",style: Theme.of(context).textTheme.bodyMedium),
                     ],
                   ),
                 ),
               ],
             ),
           ),
            Expanded(
              flex: 1,
              child: ElevatedButton(onPressed: (){}, child: Text("Join Now"
                  ,style:themeProvider.theme == ThemeMode.dark?
              const TextStyle(color: Colors.black,fontSize: 11,fontWeight: FontWeight.w700):
              const TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w700)
              )),
            )
          ],
        ),
      ),
    );
  }
}
