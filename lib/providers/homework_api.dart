import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homework/models/lesson.dart';
import 'package:http/http.dart' as http;

class HomeworkApi with ChangeNotifier {
  List<Lesson> _homeworks = [];
  List<Lesson> get homeworks {
    return _homeworks;
  }
 
  Future<void> getHomework({required int id}) async {
    
    Uri url = Uri(
      scheme: 'https',
      host: 'codeschooluzapi.pythonanywhere.com',
      path: 'lesson/get/$id/',
    );
    try {
      http.Response response = await http.get(url);

      List dataFromJson = jsonDecode(response.body);
      _homeworks = dataFromJson.map((e) => Lesson.getLesson(e)).toList();
      
    } catch (_) {
      rethrow;
    }
    notifyListeners();
  }
}
