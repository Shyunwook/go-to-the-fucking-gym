import 'package:go_to_the_fucking_gym/api/dto/workout_set.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.dto.g.dart';

@JsonSerializable()
class WorkoutDto {
  final String name;
  final List<WorkoutSetDto> sets;

  WorkoutDto({
    required this.name,
    required this.sets,
  });

  factory WorkoutDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutDtoToJson(this);
}
