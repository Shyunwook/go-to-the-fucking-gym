import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/api/dto/dto.dart';
import 'package:go_to_the_fucking_gym/api/rest_client.dart';

class WorkoutRecordController with ChangeNotifier {
  List<String> workoutList = [];

  Future<void> getWorkoutList() async {
    workoutList = await ApiInterface().getWorkouts();

    notifyListeners();
  }

  Future<Map<String, WorkoutSetDto>> getWorkoutRecentRecords(
      String workoutId) async {
    return await ApiInterface().getRecentWorkoutRecords(workoutId);
  }
}
