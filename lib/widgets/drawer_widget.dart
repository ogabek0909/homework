import 'package:flutter/material.dart';
import 'package:homework/providers/group_api.dart';
import 'package:homework/providers/homework_api.dart';
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
                      body: const SubCategory(),
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

class SubCategory extends StatefulWidget {
  const SubCategory({
    super.key,
  });

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupApi>(context, listen: false).groups;
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(groups[index].name),
          onTap: () async{
            showDialog(
              context: context,
              builder: (ctx) => const Center(child: CircularProgressIndicator.adaptive()),
            );
            await Provider.of<HomeworkApi>(context, listen: false)
                .getHomework(groups[index].id)
                .catchError(
              (error) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Something went wrong!'),
                    content: Text(error.toString()),
                  ),
                );
              },
            );
            Navigator.pop(context);
            Navigator.pop(context);
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