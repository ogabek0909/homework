import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homework/providers/group_api.dart';
import 'package:provider/provider.dart';
import '../widgets/category_widget.dart';
import '../widgets/drawer_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
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
        body: FutureBuilder(
          future: Provider.of<GroupApi>(context, listen: false).getGroup(),
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
            return CategoryWidget(scaffold: _key);
          },
        ),
      ),
    );
  }

  Widget category(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(15)),
    );
  }
}
