import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/course.dart';

class FireStoreHelper{
  static CollectionReference<Course> getCourseCollection(){
    var coursesCollection = FirebaseFirestore.instance.collection("Courses").withConverter(
        fromFirestore: (snapshot,options)=>Course.fromFirestore(snapshot.data()??{}),
        toFirestore: (course , options)=>course.toFirestore()
    );
    return coursesCollection;
  }
static Future<List<Course>> getAllCourses() async {
  var courseQuery = await getCourseCollection().get();
  List<Course> coursesList =courseQuery.docs.map((snapshot) => snapshot.data()).toList();
  return coursesList;
}

  static Future<List<Course>> getBestSellingCourses() async {
    var courseQuery = await getCourseCollection().orderBy("students",descending: true).get();
    List<Course> coursesList =courseQuery.docs.map((snapshot) => snapshot.data()).toList();
    return coursesList;
  }

}