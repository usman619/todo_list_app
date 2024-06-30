import 'package:hive/hive.dart';
part 'todo_item.g.dart';

@HiveType(typeId: 1)
class TodoItem {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isDone;

  TodoItem(this.title, {this.isDone = false});
}
