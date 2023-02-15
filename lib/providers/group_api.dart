import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:homework/models/group.dart';
import 'package:http/http.dart' as http;

class GroupApi with ChangeNotifier{

  List<Group> _groups = [];
  List<Group> get groups {
    return _groups;
  }

  Future<void> getGroup()async{
    Uri url = Uri(
      scheme: 'https',
      host: 'codeschoolhomeworkapi.pythonanywhere.com',
      path: 'student/get-groups/',
    );
    http.Response response = await http.get(url);
    List dataFromJson = jsonDecode(response.body);
    _groups = dataFromJson.map((e) => Group.getGroup(e)).toList();
    notifyListeners();
  }

}