import 'package:hive/hive.dart';
import 'package:todo_list_app/todo_item.dart';

class TodoService {
  // Private constructor
  TodoService._privateConstructor();

  // Singleton instance
  static final TodoService _instance = TodoService._privateConstructor();

  // Factory constructor to return the singleton instance
  factory TodoService() {
    return _instance;
  }

  final String _boxName = 'todoBox';
  Future<Box<TodoItem>> get _box async =>
      await Hive.openBox<TodoItem>(_boxName);

  Future<void> addItem(TodoItem todoItem) async {
    var box = await _box;
    await box.add(todoItem);
  }

  Future<List<TodoItem>> getAllItems() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteItem(int index) async {
    var box = await _box;
    await box.delete(index);
  }

  Future<void> updateIsDone(int index, TodoItem todoItem) async {
    var box = await _box;
    todoItem.isDone = !todoItem.isDone;
    await box.putAt(index, todoItem);
  }
}
