import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:homework/providers/result_api.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  final int lessonId;
  final int assignmentId;
  const ResultScreen({
    super.key,
    required this.lessonId,
    required this.assignmentId,
  });
  static const routeName = 'result-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: Provider.of<ResultApi>(context, listen: false)
              .getResult(lessonId, assignmentId),
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
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<ResultApi>(
                  builder: (context, value, child) => SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder.all(),
                        columns: [
                          const DataColumn(
                            label:  Text(
                              'Fullname',
                              style:  TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const DataColumn(
                            label: Text('Total'),
                          ),
                          ...List.generate(
                            value.allResult[0].result.length,
                            (index) => DataColumn(
                              label: Text("${index + 1} task"),
                            ),
                          ),
                          const DataColumn(
                            label: Text(
                              'Attempts',
                            ),
                          ),
                        ],
                        rows: value.allResult
                            .map(
                              (e) => DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      e.student,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      e.rightAnswers.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ...e.result.map(
                                    (e) => DataCell(
                                      Text(e['is_correct'] ? '✅' : '❌'),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        e.attempt.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
