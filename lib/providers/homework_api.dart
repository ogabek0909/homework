import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homework/models/homework.dart';
import 'package:http/http.dart' as http;

class HomeworkApi with ChangeNotifier{

  List<Homework> _homeworks = [];
  List<Homework> get homeworks {
    return _homeworks;
  }
  void search(String word){
    _homeworks = _homeworks.where((element) => element.name.contains(word)).toList();
    notifyListeners();
  }

  Future<void> getHomework([int id = 0])async{
    Uri url = Uri(
        scheme: 'https',
        host: 'codeschoolhomeworkapi.pythonanywhere.com',
        path: 'homework/get-homeworks/$id/');
    try{
    http.Response response = await http.get(url);

    List dataFromJson = jsonDecode(response.body);
    _homeworks = dataFromJson.map((e) => Homework.getHomework(e)).toList();
    
    }catch(_){
      rethrow;
    }
    notifyListeners();
  }
}