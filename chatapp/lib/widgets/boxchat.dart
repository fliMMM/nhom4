import 'package:chatapp/models/auth.dart';
import 'package:flutter/material.dart';

class BoxChat extends StatelessWidget {
  final String message;
  final bool isCurrentUserId;

  const BoxChat(
      {super.key, required this.isCurrentUserId, required this.message});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Align(
      alignment: isCurrentUserId ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.all(5),
        constraints: const BoxConstraints(maxWidth: 300),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: isCurrentUserId ? Colors.blue : Colors.grey[200],
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(message,
                  style: TextStyle(
                      color: isCurrentUserId ? Colors.white : Colors.black))),
        ),
      ),
    ));
  }
}
