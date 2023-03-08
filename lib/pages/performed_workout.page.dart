import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/workout.provider.dart';

class PerformedWorkoutPage extends StatefulWidget {
  const PerformedWorkoutPage({super.key});

  @override
  State<PerformedWorkoutPage> createState() => _PerformedWorkoutPageState();
}

class _PerformedWorkoutPageState extends State<PerformedWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    var workoutController = context.read<WorkoutController>();
    var performed = workoutController.performedWorkoutMap;

    return ListView(
      shrinkWrap: true,
      children: List.generate(
        performed.keys.length,
        (index) {
          var part = performed.keys.toList()[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(part),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children:
                      List.generate(performed[part]?.length ?? 0, (index) {
                    var workouts = performed[part];
                    var list = workouts?.entries.toList();

                    return Row(
                      children: [
                        Text(list?[index].key ?? ''),
                        const Spacer(),
                        Text(list?[index].value.length.toString() ?? ''),
                      ],
                    );
                  }),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
