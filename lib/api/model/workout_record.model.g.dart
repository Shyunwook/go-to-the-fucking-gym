// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_record.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutRecordModel _$WorkoutRecordModelFromJson(Map<String, dynamic> json) =>
    WorkoutRecordModel(
      userId: json['userId'] as String,
      volume: (json['volume'] as num).toDouble(),
      performed: (json['performed'] as List<dynamic>)
          .map((e) => PerformedDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutRecordModelToJson(WorkoutRecordModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'volume': instance.volume,
      'performed': instance.performed,
    };
