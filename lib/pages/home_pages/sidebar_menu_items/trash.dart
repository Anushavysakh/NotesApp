import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';

class Trash extends StatelessWidget {
  const Trash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage())),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.restore_from_trash),
              SizedBox(
                width: 10,
              ),
              Text(
                " Trash",
                style: TextStyle(fontSize: 26),
              )
            ]),
      ),
    );
  }

}
