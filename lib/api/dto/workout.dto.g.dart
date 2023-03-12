// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutDto _$WorkoutDtoFromJson(Map<String, dynamic> json) => WorkoutDto(
      name: json['name'] as String,
      sets: (json['sets'] as List<dynamic>)
          .map((e) => WorkoutSetDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutDtoToJson(WorkoutDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sets': instance.sets,
    };
