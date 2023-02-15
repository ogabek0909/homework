class Student {
  // final int id;
  final String fullname;
  final result;
  final int total;
  final int attempt;

  Student(
      {required this.fullname,
      required this.result,
      required this.total,
      required this.attempt});

  factory Student.getStudent(Map data) {
    int a = 0;

    for (int i = 0; i < data['result'].length; i++) {
      if (data['result'][i]['is_solved']) {
        a++;
      }
    }
    return Student(
        fullname: data['student'],
        result: data['result'],
        total: a,
        attempt: data['attempt']);
  }
}