import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homework/models/student.dart';
import 'package:http/http.dart' as http;

class StudentApi with ChangeNotifier {
  List<Student> _students = [];
  List<Student> get students {
    return _students;
  }

  Future<void> getStudent(int groupId, int homeworkId) async {
    Uri url = Uri(
        scheme: 'https',
        host: 'codeschoolhomeworkapi.pythonanywhere.com',
        path: 'homework/get-results/$groupId/$homeworkId/');

    http.Response response = await http.get(url);

    Map<String, dynamic> dataFromJson = jsonDecode(response.body);

    _students = dataFromJson['ok'].map((e) => Student.getStudent(e)).toList();
    print(_students);
    notifyListeners();
  }
}