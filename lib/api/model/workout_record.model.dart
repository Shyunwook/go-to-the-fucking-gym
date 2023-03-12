import 'package:json_annotation/json_annotation.dart';

import '../dto/dto.dart';

part 'workout_record.model.g.dart';

@JsonSerializable()
class WorkoutRecordModel {
  final String userId;
  final double volume;
  final List<PerformedDto> performed;

  const WorkoutRecordModel({
    required this.userId,
    required this.volume,
    required this.performed,
  });

  factory WorkoutRecordModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutRecordModelToJson(this);
}
