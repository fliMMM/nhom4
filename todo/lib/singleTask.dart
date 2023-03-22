import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/form.dart';
import 'package:todo/logic/data.dart';

class MySingleTask extends StatelessWidget {
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
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Starting date: ${todoItem['startDate']}"),
                    ThreeDot(
                        title: title,
                        handleDelete: handleDelete,
                        handleTodo: handleTodo)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        todoItem['title'].length > 15
                            ? '${todoItem['title'].substring(0, 16)} ...'
                            : todoItem['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Text("${Data.getDiffDay(todoItem)} Day")
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget ThreeDot({title, handleDelete, handleTodo}) {
  return RotatedBox(
    quarterTurns: 1,
    child: PopupMenuButton(
        iconSize: 30,
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
                                      handleTodo({}, 'delete', {}, {});
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Xoas")),
                              ),
                            );
                          });
                    },
                    child: const Text("Delete")),
              ),
            ]),
  );
}
