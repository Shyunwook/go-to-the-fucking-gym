import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/api/dto/dto.dart';
import 'package:go_to_the_fucking_gym/api/rest_client.dart';
import 'package:intl/intl.dart';

import '../api/model/model.dart';

class WorkoutController with ChangeNotifier {
  final performedWorkoutMap = <String, Map<String, List<PerformSet>>>{};
  double totalVolume = 0;
  DateTime? _startTime;
  DateTime? _endTime;

  Duration get workoutTime =>
      _endTime?.difference(_startTime ?? DateTime.now()) ?? Duration.zero;
  set startTime(time) => _startTime = time;

  void setPerformedWorkout(PerformSet workout) {
    if (performedWorkoutMap[workout.part] == null) {
      performedWorkoutMap[workout.part] = {};
    }
    if (performedWorkoutMap[workout.part]?[workout.workoutName] == null) {
      performedWorkoutMap[workout.part]?[workout.workoutName] = [];
    }

    performedWorkoutMap[workout.part]?[workout.workoutName]?.add(workout);

    notifyListeners();
  }

  PerformSet? getLastWorkout({
    required String part,
    required String workoutName,
  }) {
    return performedWorkoutMap[part]?[workoutName]?.last;
  }

  void setRestTimeToWorkout({
    required String part,
    required String workoutName,
    required String restTime,
  }) {
    performedWorkoutMap[part]?[workoutName]?.last.setRestTime = restTime;
    notifyListeners();
  }

  void doneWorkout() async {
    _calculateWokoutVolume();
    _endTime = DateTime.now();

    var performed = performedWorkoutMap.keys.map((part) {
      var workouts = performedWorkoutMap[part]?.keys.map(
        (name) {
          var workout = performedWorkoutMap[part]?[name] ?? [];
          var sets = workout.map((performedSet) {
            var restTime = '${performedSet.restTime}0';

            return WorkoutSetDto(
              set: performedSet.setCount,
              reps: performedSet.reps,
              weight: (performedSet.isKillogram
                  ? performedSet.kg
                  : performedSet.lb)!,
              isKillogram: performedSet.isKillogram,
              restTime: DateFormat('mm:ss:SS')
                  .parse(restTime)
                  .difference(
                    DateFormat('mm:ss:SS').parse('00:00:00'),
                  )
                  .inMilliseconds,
            );
          }).toList();

          return WorkoutDto(name: name, sets: sets);
        },
      ).toList();

      return PerformedDto(part: part, workouts: workouts ?? []);
    }).toList();

    var record = WorkoutRecordModel(
      userId: 'Bobby',
      volume: totalVolume,
      performed: performed,
    );

    await ApiInterface().setWOrkoutRecord(record: record);
  }

  void _calculateWokoutVolume() {
    totalVolume = 0;

    for (var workouts in performedWorkoutMap.values) {
      for (var performSetList in workouts.values) {
        for (var performSet in performSetList) {
          totalVolume += performSet.kg! * performSet.reps;
        }
      }
    }
  }
}

class PerformSet {
  final int reps;
  double? kg;
  double? lb;
  final int setCount;
  final String workoutName;
  final String part;
  final bool isKillogram;
  String _restTime = '';

  String get restTime => _restTime;

  set setRestTime(val) => _restTime = val;

  PerformSet({
    required this.reps,
    this.kg,
    this.lb,
    required this.setCount,
    required this.workoutName,
    required this.part,
    this.isKillogram = true,
  }) {
    if (kg != null) {
      lb = double.parse((kg! * 2.20462262185).toStringAsFixed(1));
    } else {
      kg = double.parse((lb! * 0.45359237).toStringAsFixed(1));
    }
  }

  static double convertToKg(double lb) {
    return double.parse((lb * 0.45359237).toStringAsFixed(1));
  }
}
