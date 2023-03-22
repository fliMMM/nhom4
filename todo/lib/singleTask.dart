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
              : (Caculator.compareNowAndEndDate(todoItem)
                  ? const Color.fromARGB(190, 255, 240, 2)
                  : Colors.red),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 15, top: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ngày bắt đầu: ${todoItem['startDate']}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Checkbox(
                              checkColor: Colors.white,
                              value: todoItem['isFinish'],
                              onChanged: (value) {
                                handleTodo(todoItem['id'], 'finish', {}, {});
                              }),
                        ),
                        SizedBox(
                          width: 30,
                          child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        content: SizedBox(
                                          height: 100,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                handleTodo(todoItem['id'],
                                                    'delete', {}, {});
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Xóa")),
                                        ),
                                      );
                                    });
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 30,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todoItem['title'].length > 14
                          ? '${todoItem['title'].substring(0, 14)} ...'
                          : todoItem['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white),
                    ),
                    Text(
                      Data.getDiffDay(todoItem),
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
