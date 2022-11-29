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
            children: const [
              Icon(Icons.settings),
              SizedBox(
                width: 10,
              ),
              Text(
                " Settings",
                style: TextStyle(fontSize: 26),
              )
            ]),
      ),
    );
  }
}
