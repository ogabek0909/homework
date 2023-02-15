import 'package:flutter/material.dart';
import 'package:homework/providers/homework_api.dart';
import 'package:homework/providers/student_api.dart';
import 'package:homework/widgets/homework_tap_widget.dart';
import 'package:homework/widgets/student_tap_widget.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  const CategoryWidget({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () => scaffold.currentState!.openDrawer(),
                icon: const Icon(Icons.menu),
              ),
              const SizedBox(width: 10),
              const Text('Group Name'),
              const SizedBox(width: 10),
              const Spacer(),
              const Expanded(
                flex: 2,
                child: TabBar(
                  dividerColor: Colors.grey,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Homework'),
                    Tab(text: 'People'),
                    Tab(text: 'Teachers'),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              Consumer<HomeworkApi>(
                builder: (context, value, child) => value.homeworks.isEmpty
                    ? const Center(
                        child: Text('You have no homeworks, yet!'),
                      )
                    : HomeworkTapWidget(data: value.homeworks),
              ),
              Consumer<StudentApi>(
                builder: (context, value, child) => value.students.isEmpty
                    ? const Center(
                        child: Text('You have no homeworks, yet!'),
                      )
                    : StudentTapWidget(data: value.students),
              ),
              const Center(
                child: Text('salom'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
