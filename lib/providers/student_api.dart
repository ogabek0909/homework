import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homework/models/student.dart';
import 'package:http/http.dart' as http;

class StudentApi with ChangeNotifier {
  List<Student> _students = [];
  List<Student> get students {
    return _students;
  }

  Future<void> getStudent({int? groupId}) async {
    String path =
        groupId != null ? '/get-students-from-group/$groupId/' : 'student/all/';
    Uri url = Uri(
      scheme: 'https',
      host: 'codeschooluzapi.pythonanywhere.com',
      path: path,
    );

    http.Response response = await http.get(url);
    // print(response.body);

    List dataFromJson = jsonDecode(response.body);

    _students = dataFromJson.map((e) => Student.getStudent(e)).toList();
    // print(_students);
    notifyListeners();
  }
}
