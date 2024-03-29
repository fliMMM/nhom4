import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  final titleController = TextEditingController();
  final handleTodo;
  dynamic action;
  dynamic preTitle;

  MyForm({super.key, this.handleTodo, this.action, this.preTitle}) {
    if (action == 'edit') {
      titleController.text = preTitle;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SizedBox(
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
