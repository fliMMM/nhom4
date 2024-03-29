import 'package:flutter/material.dart';
import 'package:todo/CreateTask.dart';
import 'package:todo/logic/data.dart';
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
  Data myData = Data();
  List<Map> todoList = [];

  @override
  void initState() {
    super.initState();
    todoList = myData.getData();
  }

  void handleTodo(item, action, currentItem, preItem) {
    switch (action) {
      case 'edit':
        // if (Data.validData(item) == false) return;
        myData.handleEdit(preItem, currentItem);
        setState(() {
          todoList = myData.getData();
        });
        Navigator.pop(context);

        break;
      case 'delete':
        myData.handleDelete(item);
        setState(() {
          todoList = myData.getData();
        });
        break;
      case 'finish':
        myData.finish(item);
        setState(() {
          todoList = myData.getData();
        });
        break;
      case 'Add':
        if (Data.validData(item) == false) return;
        myData.handleAdd(item);
        setState(() {
          todoList = myData.getData();
        });
        Navigator.pop(context);
        break;
    }
  }

  void handleDelete(title) {
    setState(() {
      myData.getData().removeAt(myData.getData().indexOf(title));
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var list = List.generate(todoList.length, (index) {
      return TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateTask(
                          handleTodo: handleTodo,
                          preItem: todoList[index],
                          action: 'edit',
                        )));
          },
          child: MySingleTask(
            time: "7:30 AM",
            todoItem: todoList[index],
            handleDelete: handleDelete,
            handleTodo: handleTodo,
          ));
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 224, 141, 116),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(widget.title),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateTask(
                            handleTodo: handleTodo,
                            action: 'Add',
                          )));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          )
        ]),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: list,
      ),
    );
  }
}
