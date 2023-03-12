import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:homework/models/course.dart';

class CourseApi with ChangeNotifier {
  List<Course> _courses = [];
  List<Course> get courses {
    return [..._courses];
  }

  Future<void> getCourse() async {
    Uri url = Uri.parse('https://codeschooluzapi.pythonanywhere.com/course/');
    http.Response response = await http.get(url);
    List dataFromJson = jsonDecode(response.body);
    _courses = dataFromJson.map((e) => Course.getCourse(e)).toList();
    // print(_courses[0].name);
    notifyListeners();
  }
}
