import 'package:flutter/material.dart';

class WorkoutController with ChangeNotifier {
  final performedWorkoutMap = <String, Map<String, List<PerformSet>>>{};
  double totalVolume = 0;
  DateTime? startTime;
  DateTime? endTime;

  Duration get workoutTime =>
      endTime?.difference(startTime ?? DateTime.now()) ?? Duration.zero;

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

  void calculateWokoutVolume() {
    totalVolume = 0;

    for (var workouts in performedWorkoutMap.values) {
      for (var performSetList in workouts.values) {
        for (var performSet in performSetList) {
          totalVolume += performSet.kg! * performSet.reps;
        }
      }
    }
    notifyListeners();
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
