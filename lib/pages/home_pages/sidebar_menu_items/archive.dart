import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  const Archive({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.archive_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                " Archive",
                style: TextStyle(fontSize: 26),
              )
            ]),
      ),
    );
  }
}
