import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/form.dart';

class MySingleTask extends StatelessWidget {
  String time = "";
  String title = "";
  Function handleDelete;
  Function handleTodo;
  MySingleTask(
      {super.key,
      required this.time,
      required this.title,
      required this.handleDelete,
      required this.handleTodo});

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
                    const Text("Starting date: 20/12/2022"),
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
                        title.length > 15
                            ? '${title.substring(0, 16)} ...'
                            : title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const Text("1days")
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
                  value: 'edit',
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return MyForm(
                                preTitle: title,
                                action: 'edit',
                                handleTodo: handleTodo,
                              );
                            });
                      },
                      child: const Text("Edit"))),
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
                                      handleDelete(title);
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
