class Course{
  String? id;
  String? title;
  String? image;
  int? students;
  Course({this.id,required this.title, required this.image,required this.students});
  Course.fromFirestore(Map<String , dynamic> data){
    title = data["title"];
    students = data["students"];
    image = data["image"];
    id = data["id"];
  }
  Map<String , dynamic> toFirestore(){
    return{
      "title":title,
      "students":students,
      "image":image,
      "id":id,
    };
  }
}