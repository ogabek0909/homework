import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/assignment_api.dart';
import '../providers/homework_api.dart';
import '../providers/student_api.dart';
import '../widgets/assignment_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/lesson_tap_widget.dart';
import '../widgets/student_tap_widget.dart';

class CategoriesScreen extends StatefulWidget {
  final int id;
  const CategoriesScreen({super.key, required this.id});
  static const routeName = 'categoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 100),
      child: Scaffold(
        key: _key,
        endDrawerEnableOpenDragGesture: false,
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Group name',
                  ),
                  const SizedBox(width: 10),
                  const Spacer(),
                  const Expanded(
                    flex: 2,
                    child: TabBar(
                      dividerColor: Colors.grey,
                      indicatorColor: Colors.orange,
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 119, 115, 115),
                      ),
                      tabs: [
                        Tab(text: 'Assignments'),
                        Tab(text: 'Students'),
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
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FutureBuilder(
                    future: Provider.of<HomeworkApi>(context, listen: false)
                        .getHomework(id: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SpinKitThreeInOut(
                            color: Colors.black,
                            size: 30,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        Provider.of<AssignmentApi>(context, listen: false)
                            .nullAssignment();
                        return Row(
                          children: const [
                            LessonTapWidget(),
                            AssignmentWidget(),
                          ],
                        );
                      }
                    },
                  ),
                  FutureBuilder(
                    future: Provider.of<StudentApi>(context, listen: false)
                        .getStudent(groupId: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return StudentTapWidget(
                        data: Provider.of<StudentApi>(context, listen: false)
                            .students,
                      );
                    },
                  ),
                  const Center(
                    child: Text('This screen does not work'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
