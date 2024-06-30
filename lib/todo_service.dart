import 'package:hive/hive.dart';
import 'package:todo_list_app/todo_item.dart';

class TodoService {
  final String _boxName = 'todoBox';
  Future<Box<ToDoItem>> get _box async =>
      await Hive.openBox<ToDoItem>(_boxName);

  Future<void> addItem(ToDoItem todoItem) async {
    var box = await _box;
    await box.add(todoItem);
  }

  Future<List<ToDoItem>> getAllItems() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteItem(int index) async {
    var box = await _box;
    await box.delete(index);
  }

  Future<void> updateIsDone(int index, ToDoItem todoItem) async {
    var box = await _box;
    todoItem.isDone = !todoItem.isDone;
    await box.putAt(index, todoItem);
  }
}
