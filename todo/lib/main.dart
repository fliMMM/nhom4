import 'package:flutter/material.dart';
import 'package:todo/form.dart';
import 'package:todo/singleTask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoList = [];

  void handleAddTodo(title) {
    setState(() {
      todoList.add(title);
    });
  }

  void handleDelete(title) {
    setState(() {
      todoList.removeAt(todoList.indexOf(title));
    });

    Navigator.pop(context);
  }

  void handleEdit(currentTitle, preTitle) {
    int preIndex = todoList.indexOf(preTitle);
    setState(() {
      todoList[preIndex] = currentTitle;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: List.generate(todoList.length, (index) {
            return MySingleTask(
              time: "7:30 AM",
              title: todoList[index],
              handleDelete: handleDelete,
              handleEdit: handleEdit,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return MyForm(
                    handleAddTodo: (title) => {handleAddTodo(title)},
                  );
                });
          },
          child: const Icon(Icons.add),
        ));
  }
}
