import 'package:json_annotation/json_annotation.dart';

import 'performed.dto.dart';

part 'workout_record.dto.g.dart';

@JsonSerializable()
class WorkoutRecordDto {
  final String userId;
  final double volume;
  final List<PerformedDto> performed;
  final TimeStamp timeStamp;

  const WorkoutRecordDto({
    required this.userId,
    required this.volume,
    required this.performed,
    required this.timeStamp,
  });

  factory WorkoutRecordDto.fromJson(Map<String, dynamic> json) =>
      _$WorkoutRecordDtoFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutRecordDtoToJson(this);
}

@JsonSerializable()
class TimeStamp {
  @JsonKey(name: '_seconds')
  final int seconds;
  @JsonKey(name: '_nanoseconds')
  final int nanoseconds;

  TimeStamp({
    required this.seconds,
    required this.nanoseconds,
  });

  factory TimeStamp.fromJson(Map<String, dynamic> json) =>
      _$TimeStampFromJson(json);
  Map<String, dynamic> toJson() => _$TimeStampToJson(this);
}
