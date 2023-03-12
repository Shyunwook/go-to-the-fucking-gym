// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performed.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformedDto _$PerformedDtoFromJson(Map<String, dynamic> json) => PerformedDto(
      part: json['part'] as String,
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => WorkoutDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PerformedDtoToJson(PerformedDto instance) =>
    <String, dynamic>{
      'part': instance.part,
      'workouts': instance.workouts,
    };
