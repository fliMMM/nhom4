import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final titleController = TextEditingController();
  late Function handleTodo;
  dynamic action;
  dynamic preTitle;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create"),
      ),
      body: SizedBox(
        height: 200,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "title"),
              ),
              ElevatedButton(
                  onPressed: () {
                    showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                  },
                  child: const Text("time")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (action == 'edit') {
                          handleTodo(titleController.text, 'edit',
                              titleController.text, preTitle);
                          Navigator.pop(context);
                          return;
                        }
                        handleTodo(
                          titleController.text,
                          action,
                        );
                      },
                      child: Text(action == "edit" ? "edit" : "Add"))
                ],
              )
            ]),
      ),
    );
  }
}
