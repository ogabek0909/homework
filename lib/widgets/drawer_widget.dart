import 'package:flutter/material.dart';
import 'package:homework/providers/group_api.dart';
import 'package:homework/providers/homework_api.dart';
import 'package:homework/providers/student_api.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Placeholder(),
          ),
          ExpansionPanelList.radio(
            children: categories
                .map((categoryItem) => ExpansionPanelRadio(
                      canTapOnHeader: true,
                      value: categoryItem,
                      headerBuilder: (context, isExpanded) => ListTile(
                        title: Text(categoryItem),
                        leading: const Icon(Icons.payment),
                      ),
                      body: SubCategory(),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  final List<String> categories = [
    'Python',
    'Dart',
    'Codewars',
    'Flutter',
    'Backend',
    'Artificial Intellegance',
  ];

  String headerDrawer = 'Python';
}

class SubCategory extends StatelessWidget {
  const SubCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupApi>(context,listen: false).groups;
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(groups[index].name),
          onTap: () async{
            Provider.of<HomeworkApi>(context,listen: false).getHomework(groups[index].id);
            await Provider.of<StudentApi>(context,listen: false).getStudent(groups[index].id, 14);
          },
        ),
      ),
    );
  }
}
/* 
ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.payment_sharp),
                      title: Text(
                        categories[index],
                        style: const TextStyle(),
                      ),
                      trailing:
                          const Icon(Icons.arrow_drop_down_circle_outlined),
                    ),
                  ),
 */