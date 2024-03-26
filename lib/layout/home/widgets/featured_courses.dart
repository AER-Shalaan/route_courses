import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/model/course.dart';
import '../../../shared/providers/theme_provider.dart';
import '../../../style/app_colors.dart';

class FeatureCourses extends StatelessWidget {
  Course course;
  FeatureCourses({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: height*0.29,
        width: width*0.54,
        decoration: BoxDecoration(color: themeProvider.theme == ThemeMode.dark?AppColors.homeContainerDarkColor:Colors.white,borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(width*0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height:height*0.13,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image:DecorationImage(image: NetworkImage(course.image??"https://techsouthafrica.co.za/wp-content/uploads/2023/01/No-Image.jpg"),fit: BoxFit.fill)
                  )
                ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height*0.01),
                      Text(course.title??"",style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: height*0.005),
                      Text("${course.students} Students",style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.04),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        child: Text("Enroll Now"
                            ,style:themeProvider.theme == ThemeMode.dark?
                            const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700):
                            const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700))
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*0.01)
            ],
          ),
        ),
      ),
    );
  }
}
