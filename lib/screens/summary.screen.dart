import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_to_the_fucking_gym/pages/performed_workout.page.dart';
import 'package:go_to_the_fucking_gym/provider/workout.provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../utils.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  var format = NumberFormat('###,###,###,###.#', "en_US");

  @override
  Widget build(BuildContext context) {
    var workoutController = context.watch<WorkoutController>();
    print(workoutController.workoutTime);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Text("Total Workout Volume"),
            ),
            Text(
              format.format(
                double.parse(
                  Utils.decimalParser(workoutController.totalVolume),
                ),
              ),
            ),
            const Center(
              child: Text("Total Workout Time"),
            ),
            Text(Utils.durationFormatter(workoutController.workoutTime)),
            const Text('Great JOB!'),
            const PerformedWorkoutPage(),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text(
                'GO HOME',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
