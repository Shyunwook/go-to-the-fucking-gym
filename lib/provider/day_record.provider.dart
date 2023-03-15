import 'package:flutter/material.dart';
import 'package:go_to_the_fucking_gym/api/rest_client.dart';

import '../api/dto/dto.dart';

class DayRecordController with ChangeNotifier {
  List<WorkoutRecordDto> workoutRecords = [];

  Future<void> getDayRecord(String day) async {
    workoutRecords = await ApiInterface().getWorkoutRecords(day);

    notifyListeners();
  }
}
