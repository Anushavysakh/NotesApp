import 'package:flutter/material.dart';
class Settings extends StatelessWidget {
  const Settings({
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
            children: [
              Icon(Icons.settings,color: Colors.black),
              SizedBox(
                width: 10,
              ),
              Text(
                " Setting",
                style: TextStyle(fontSize: 26),
              )
            ]),
      ),
    );
  }
}
