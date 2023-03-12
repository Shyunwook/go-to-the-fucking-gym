import 'package:json_annotation/json_annotation.dart';

part 'workout_set.dto.g.dart';

@JsonSerializable()
class WorkoutSetDto {
  final int set;
  final int reps;
  final double weight;
  final bool isKillogram;
  final int restTime;

  WorkoutSetDto({
    required this.set,
    required this.reps,
    required this.weight,
    required this.isKillogram,
    required this.restTime,
  });

  factory WorkoutSetDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutSetDtoToJson(this);
}
