import 'package:flutter/material.dart';

import '../models/homework.dart';

class HomeworkTapWidget extends StatelessWidget {
  final List<Homework> data;
  const HomeworkTapWidget({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ListTile(
        
        title: Text(data[index].name),
      ),
    );
  }
}
