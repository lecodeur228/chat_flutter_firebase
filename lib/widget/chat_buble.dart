import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  bool isSend;
  String text;
  ChatBuble({required this.text, required this.isSend, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSend
            ? const Color.fromARGB(255, 250, 233, 170)
            : const Color.fromARGB(255, 247, 246, 242),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
