// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSetDto _$WorkoutSetDtoFromJson(Map<String, dynamic> json) =>
    WorkoutSetDto(
      set: json['set'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as num).toDouble(),
      isKillogram: json['isKillogram'] as bool,
      restTime: json['restTime'] as int,
    );

Map<String, dynamic> _$WorkoutSetDtoToJson(WorkoutSetDto instance) =>
    <String, dynamic>{
      'set': instance.set,
      'reps': instance.reps,
      'weight': instance.weight,
      'isKillogram': instance.isKillogram,
      'restTime': instance.restTime,
    };
