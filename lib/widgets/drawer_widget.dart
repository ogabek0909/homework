import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:homework/providers/course_api.dart';
import 'package:homework/providers/group_api.dart';
import 'package:homework/providers/homework_api.dart';
import 'package:homework/screens/categories_screen.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CourseApi>(context, listen: false).courses;
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Placeholder(),
          ),
          ExpansionPanelList.radio(
            children: courses
                .map(
                  (categoryItem) => ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: categoryItem,
                    headerBuilder: (context, isExpanded) => ListTile(
                      title: Text(categoryItem.name),
                      leading: const Icon(Icons.payment),
                    ),
                    body: SubCategory(
                      id: categoryItem.id,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class SubCategory extends StatefulWidget {
  final int id;

  const SubCategory({
    super.key,
    required this.id,
  });

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<GroupApi>(context, listen: false).getGroup(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SpinKitThreeInOut(
                color: Colors.black,
                size: 20,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          // print(groups);
          return SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].name,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    context.goNamed(
                      CategoriesScreen.routeName,
                      params: {
                        'id': snapshot.data![index].id.toString(),
                      },
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (ctx) => const Center(
                    //     child: CircularProgressIndicator.adaptive(),
                    //   ),
                    // );
                    // await Provider.of<HomeworkApi>(context, listen: false)
                    //     .getHomework(id:snapshot.data![index].id)
                    //     .catchError(
                    //   (error) {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => AlertDialog(
                    //         title: const Text('Something went wrong!'),
                    //         content: Text(error.toString()),
                    //       ),
                    //     );
                    //   },
                    // );
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                  },
                );
              },
            ),
          );
        }
      },
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