import 'package:flutter/material.dart';

class BoxChat extends StatelessWidget {
  final String data;
  final bool isUser;
  const BoxChat({super.key, required this.isUser,required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
        Align(
          alignment: isUser?Alignment.topRight:Alignment.topLeft,
          child:  Container(
            constraints: const BoxConstraints(maxWidth: 200),
              child: Card(
                color: isUser?Colors.blue:Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:Text(data,style: TextStyle(color:isUser?Colors.white:Colors.black))
                  ),
              ),
          ),
        )
    );
  }
}