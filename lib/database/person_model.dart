import 'package:json_annotation/json_annotation.dart';
part 'person_model.g.dart';

@JsonSerializable()
class Person {
  final int id;
  final String name;
  final String surname;
  final int age;

  Person(this.id, this.name, this.surname, this.age);

  factory Person.fromJson(Map<String, dynamic> json) =>
      _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
