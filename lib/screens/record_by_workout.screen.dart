import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/provider/workout_record.provider.dart';
import 'package:provider/provider.dart';

class RecordByWorkoutScreen extends StatelessWidget {
  const RecordByWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutRecordController()..getWorkoutList(),
      child: const _RecordByWorkoutScreen(),
    );
  }
}

class _RecordByWorkoutScreen extends StatefulWidget {
  const _RecordByWorkoutScreen();

  @override
  State<_RecordByWorkoutScreen> createState() => __RecordByWorkoutScreenState();
}

class __RecordByWorkoutScreenState extends State<_RecordByWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    var recordController = context.watch<WorkoutRecordController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '운동 리스트',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var workout = recordController.workoutList[index];
                  return ElevatedButton(
                    onPressed: () async {
                      var data = await recordController
                          .getWorkoutRecentRecords(workout);
                      print(data);
                    },
                    child: Text(workout),
                  );
                },
                itemCount: recordController.workoutList.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
