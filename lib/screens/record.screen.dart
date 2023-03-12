import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/provider/record.provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (constext) => RecordController(),
      child: const _RecordScreen(),
    );
  }
}

class _RecordScreen extends StatefulWidget {
  const _RecordScreen();

  @override
  State<_RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<_RecordScreen> {
  DateTime currentDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var recordController = context.watch<RecordController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                currentDay = selectedDay;
              },
            ),
            ElevatedButton(
              onPressed: () {
                recordController
                    .getDayRecord(DateFormat('yyyyMMdd').format(currentDay));
              },
              child: const Text('날짜 조회'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recordController.workoutRecords.length,
              itemBuilder: (context, index) {
                var record = recordController.workoutRecords[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yyyy.MM.dd hh:mm')
                            .format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  record.timeStamp.seconds * 1000),
                            )
                            .toString(),
                      ),
                      Text(record.volume.toString()),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
