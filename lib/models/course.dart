class Course{
  final int id;
  final String name;

  Course({required this.id,required this.name});
  factory Course.getCourse(Map data){
    return Course(id: data['id'], name: data['name']);
  }
}