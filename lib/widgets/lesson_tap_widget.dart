import 'package:flutter/material.dart';
import 'package:homework/providers/assignment_api.dart';
import 'package:homework/providers/homework_api.dart';
import 'package:provider/provider.dart';

import '../models/lesson.dart';

class LessonTapWidget extends StatelessWidget {
  const LessonTapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Lesson> data =
        Provider.of<HomeworkApi>(context, listen: false).homeworks;
    return Flexible(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white54,
        ),
        child: Column(
          children: [
            const Text(
              'Lessons',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(
                      data[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 110, 109, 109),
                      ),
                    ),
                    onTap: () async {
                      Provider.of<AssignmentApi>(context, listen: false)
                          .onVisible(false);
                      await Provider.of<AssignmentApi>(context, listen: false)
                          .getAssignments(data[index].id);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
