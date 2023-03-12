import 'package:json_annotation/json_annotation.dart';

import 'performed.dto.dart';

part 'workout_record.dto.g.dart';

@JsonSerializable()
class WorkoutRecordDto {
  final String userId;
  final double volume;
  final List<PerformedDto> performed;

  WorkoutRecordDto({
    required this.userId,
    required this.volume,
    required this.performed,
  });

  factory WorkoutRecordDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutRecordDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutRecordDtoToJson(this);
}
