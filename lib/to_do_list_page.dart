import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/todo_item.dart';
import 'package:todo_list_app/todo_service.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});
  final TodoService _todoService = TodoService(); //will be changed
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TodoItem>('todoBox').listenable(),
        builder: (BuildContext context, Box<TodoItem> box, _) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todoItem = box.getAt(index);
              return ListTile(
                title: Text(todoItem!.title,
                    style: TextStyle(
                      decoration: todoItem.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    )),
                leading: Checkbox(
                  value: todoItem.isDone,
                  onChanged: (value) {
                    _todoService.updateIsDone(index, todoItem);
                  },
                  activeColor: Colors.black,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _todoService.deleteItem(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Add Todo'),
                    content: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter your todo',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              var todoItem = TodoItem(_controller.text);
                              _todoService.addItem(todoItem);
                              _controller.clear();
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ))
                    ]);
              });
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
