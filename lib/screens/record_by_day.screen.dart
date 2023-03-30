import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/provider/day_record.provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordByDayScreen extends StatelessWidget {
  const RecordByDayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (constext) => DayRecordController(),
      child: const _RecordByDayScreen(),
    );
  }
}

class _RecordByDayScreen extends StatefulWidget {
  const _RecordByDayScreen();

  @override
  State<_RecordByDayScreen> createState() => _RecordByDayScreenState();
}

class _RecordByDayScreenState extends State<_RecordByDayScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    var recordController = context.watch<DayRecordController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  print(selectedDay);
                  print(focusedDay);
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedDay != null) {
                  recordController.getDayRecord(
                      DateFormat('yyyyMMdd').format(_selectedDay!));
                }
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
