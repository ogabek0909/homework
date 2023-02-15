import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homework/providers/group_api.dart';
import 'package:homework/providers/homework_api.dart';
import 'package:homework/providers/student_api.dart';
import 'package:homework/screens/categories_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GroupApi()),
        ChangeNotifierProvider(create: (context) => HomeworkApi()),
        ChangeNotifierProvider(create: (context) => StudentApi())
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              name: CategoriesScreen.routeName,
              builder: (context, state) => const CategoriesScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
