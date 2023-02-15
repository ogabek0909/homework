class Homework {
  final String name;
  final int id;
  
  Homework({required this.id,required this.name});

  factory Homework.getHomework(Map data){
    return Homework(id: data['id'], name: data['name']);
  }
}