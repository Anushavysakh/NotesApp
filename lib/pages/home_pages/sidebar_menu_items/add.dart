import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  const Add({
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
              Icon(Icons.add),
              SizedBox(
                width: 10,
              ),
              Text(
                " Create a new label",
                style: TextStyle(fontSize: 26),
              )
            ]),
      ),
    );
  }
}