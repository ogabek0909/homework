class Assignment {
  final int id;
  final String name;
  final int courseId;
  final String link;
  final String type;
  final String description;
  Assignment({
    required this.id,
    required this.courseId,
    required this.name,
    required this.link,
    required this.type,
    required this.description,
  });

  factory Assignment.getAssignment(Map data) {
    return Assignment(
      id: data['id'],
      courseId: data['course'],
      name: data['name'],
      link: data['link'],
      type: data['type']['name'],
      description: data['description'],
    );
  }
}
