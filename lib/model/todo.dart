import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo{
  @HiveField(0)
  String ?title;
  @HiveField(1)
  String ?discrib;
  Todo({this.discrib,this.title});

}