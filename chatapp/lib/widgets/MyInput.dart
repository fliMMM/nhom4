import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyInput extends StatefulWidget {
  String label;
  TextEditingController textEditingController;
  MyInput(
      {super.key, required this.label, required this.textEditingController});

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.label != "Email" && obscureText,
      controller: widget.textEditingController,
      decoration: InputDecoration(
          suffixIcon: widget.label != "Email"
              ? IconButton(
                  icon: obscureText == true
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : null,
          labelText: widget.label,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 2, color: Color.fromARGB(49, 86, 126, 153))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  width: 2, color: Color.fromARGB(49, 86, 126, 153)))),
    );
  }
}
