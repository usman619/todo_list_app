import 'package:hive/hive.dart';
part 'todo_item.g.dart';

@HiveType(typeId: 1)
class ToDoItem {
  @HiveField(0)
  String title;
  @HiveField(1, defaultValue: false)
  bool isDone;

  ToDoItem(this.title, this.isDone);
}
