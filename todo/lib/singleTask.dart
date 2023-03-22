import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/form.dart';
import 'package:todo/logic/caculate.dart';
import 'package:todo/logic/data.dart';

class MySingleTask extends StatelessWidget {
  Data myData = Data();
  String time = "";
  String title = "";
  Map todoItem;
  Function handleDelete;
  Function handleTodo;
  MySingleTask(
      {super.key,
      required this.time,
      required this.handleDelete,
      required this.handleTodo,
      required this.todoItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
          color: todoItem['isFinish']
              ? Colors.green
              : (Caculator.quaHan(todoItem)
                  ? Color.fromARGB(255, 224, 141, 116)
                  : Colors.red),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Starting date: ${todoItem['startDate']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ThreeDot(
                              id: todoItem['id'],
                              handleDelete: handleDelete,
                              handleTodo: handleTodo),
                          Checkbox(
                              checkColor: Colors.white,
                              value: todoItem['isFinish'],
                              onChanged: (value) {
                                handleTodo(todoItem['id'], 'finish', {}, {});
                              }),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todoItem['title'].length > 15
                          ? '${todoItem['title'].substring(0, 16)} ...'
                          : todoItem['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    Text(
                      "${Data.getDiffDay(todoItem)} Day",
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget ThreeDot({id, handleDelete, handleTodo}) {
  return PopupMenuButton(
      iconSize: 30,
      icon: const Icon(
        Icons.more_horiz,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              value: 'delete',
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            content: SizedBox(
                              height: 100,
                              child: ElevatedButton(
                                  onPressed: () {
                                    handleTodo(id, 'delete', {}, {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Xoas")),
                            ),
                          );
                        });
                  },
                  child: const Text("Delete")),
            ),
          ]);
}
