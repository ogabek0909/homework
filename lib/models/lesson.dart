class Lesson {
  final String name;
  final int id;

  
  Lesson({required this.id,required this.name});

  factory Lesson.getLesson(Map data){
    return Lesson(id: data['id'], name: data['name']);
  }
}