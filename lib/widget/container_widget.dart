import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  String path;
  String name;
  String time;
  ContainerWidget(
      {required this.path, required this.name, required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 8,
      color: Colors.white,
      child: Card(
        elevation: 2.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.amberAccent,
                backgroundImage: NetworkImage(path),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
