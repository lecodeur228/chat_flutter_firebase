import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  TextEditingController controller;
  String text;
  bool isObscure;
  MyInput(
      {required this.controller,
      required this.text,
      required this.isObscure,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      obscureText: isObscure,
    );
  }
}
