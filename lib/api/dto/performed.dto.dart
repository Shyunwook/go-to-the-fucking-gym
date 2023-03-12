import 'package:go_to_the_fucking_gym/api/dto/workout.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'performed.dto.g.dart';

@JsonSerializable()
class PerformedDto {
  final String part;
  final List<WorkoutDto> workouts;

  PerformedDto({
    required this.part,
    required this.workouts,
  });

  factory PerformedDto.fromJson(Map<String, dynamic> json) =>
      _$PerformedDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PerformedDtoToJson(this);
}
