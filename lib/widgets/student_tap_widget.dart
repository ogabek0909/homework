import 'package:flutter/material.dart';
import 'package:homework/models/student.dart';

class StudentTapWidget extends StatelessWidget {
  final List<Student> data;
  const StudentTapWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(data[index].fullname),
      ),
    );
  }
}
