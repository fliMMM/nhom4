import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MySingleTask extends StatelessWidget {
  final titleController = TextEditingController();
  String time = "";
  String title = "";
  Function handleDelete;
  Function handleEdit;
  MySingleTask(
      {super.key,
      required this.time,
      required this.title,
      required this.handleDelete,
      required this.handleEdit}) {
    titleController.text = title;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(time,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0))),
                      PopupMenuButton(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem(
                                    value: 'edit',
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  content: SizedBox(
                                                    height: 200,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextFormField(
                                                            controller:
                                                                titleController,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        "title"),
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                showTimePicker(
                                                                    context:
                                                                        context,
                                                                    initialTime:
                                                                        TimeOfDay
                                                                            .now());
                                                              },
                                                              child: const Text(
                                                                  "time")),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors.red),
                                                                child: const Text(
                                                                    "Cancel"),
                                                              ),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    handleEdit(
                                                                        titleController
                                                                            .text,
                                                                        title);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          "Edit"))
                                                            ],
                                                          )
                                                        ]),
                                                  ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                content: SizedBox(
                                                  height: 100,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        handleDelete(title);
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text("Xoas")),
                                                ),
                                              );
                                            });
                                      },
                                      child: const Text("Delete")),
                                ),
                              ])
                    ],
                  )
                ],
              ),
            )));
  }
}
