import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list_app/to_do_list_page.dart';
import 'package:todo_list_app/todo_item.dart';
import 'package:todo_list_app/todo_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: _todoService.getAllItems(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return TodoListPage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
