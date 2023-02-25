import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyForm extends StatelessWidget {
  final titleController = TextEditingController();
  final handleAddTodo;

  MyForm({super.key, this.handleAddTodo});
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
                        handleAddTodo(titleController.text);
                        Navigator.pop(context);
                      },
                      child: const Text("Add"))
                ],
              )
            ]),
      ),
    );
  }
}
