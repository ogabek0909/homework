import 'package:flutter/material.dart';
import 'package:homework/models/student.dart';

class StudentTapWidget extends StatelessWidget {
  final List<Student> data;
  const StudentTapWidget({super.key, this.data = const []});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                width: 1000,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(data[index].lastName),
                      subtitle: Text(data[index].firstName),
                    ),
                  ),
                ),
              ),
          ),
        )
        : const Center(
            child: Text('This group does not have students'),
          );
  }
}
