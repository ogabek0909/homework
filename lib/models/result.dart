class Result {
  final String student;
  final int attempt;
  final List result;
  final int rightAnswers;
  Result({
    required this.student,
    required this.attempt,
    required this.result,
    required this.rightAnswers,
  });

  factory Result.getResult(Map data) {
    int rightAnswerss = 0;
    for (Map i in data['result']) {
      if (i['is_correct']) {
        rightAnswerss++;
      }
    }
    return Result(
      student: data['student'],
      attempt: data['attempt'],
      result: data['result'],
      rightAnswers: rightAnswerss,
    );
  }
}
