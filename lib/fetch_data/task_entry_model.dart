import 'package:json_annotation/json_annotation.dart';
part 'task_entry_model.g.dart';

@JsonSerializable()
class TaskEntry {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TaskEntry(this.userId, this.id, this.title, this.completed);

  factory TaskEntry.fromJson(Map<String, dynamic> json) =>
      _$TaskEntryFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntryToJson(this);
}

class TaskEntryRsp {
  List<TaskEntry> tasks;

  TaskEntryRsp(this.tasks);

  factory TaskEntryRsp.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      List<TaskEntry> l = new List();
      for (var value in json) {
        l.add(new TaskEntry.fromJson(value));
      }
      return new TaskEntryRsp(l);
    }
  }
}