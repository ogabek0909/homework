import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:homework/models/course.dart';
import 'package:homework/providers/assignment_api.dart';
import 'package:homework/providers/group_api.dart';
import 'package:homework/screens/categories_screen.dart';
import 'package:provider/provider.dart';

class GridItemWidget extends StatelessWidget {
  final Course item;
  const GridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: SpinKitThreeInOut(
              color: Colors.black,
              size: 30,
            ),
          ),
        );
        await Provider.of<GroupApi>(context, listen: false).getGroup(item.id);
        Navigator.pop(context);
        if (Provider.of<GroupApi>(context, listen: false).groups.isEmpty) {
          return;
        }
        Provider.of<AssignmentApi>(context,listen: false).onVisible(false);
        Provider.of<AssignmentApi>(context,listen: false).nullAssignment();
        context.goNamed(
          CategoriesScreen.routeName,
          params: {
            'id': Provider.of<GroupApi>(context, listen: false)
                .groups[0]
                .id
                .toString(),
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
