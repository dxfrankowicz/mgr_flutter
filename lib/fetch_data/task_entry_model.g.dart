// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEntry _$TaskEntryFromJson(Map<String, dynamic> json) {
  return TaskEntry(
    json['userId'] as int,
    json['id'] as int,
    json['title'] as String,
    json['completed'] as bool,
  );
}

Map<String, dynamic> _$TaskEntryToJson(TaskEntry instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
