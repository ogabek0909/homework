class Group {
  final String name;
  final int id;
  
  Group({required this.id,required this.name});

  factory Group.getGroup(Map data){
    return Group(id: data['id'], name: data['name']);
  }
}