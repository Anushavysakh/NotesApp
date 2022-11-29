import 'package:flutter/material.dart';

import '../../home_page.dart';

class HelpAndFeedback extends StatelessWidget {
  const HelpAndFeedback({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));

    },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.question_mark),
              SizedBox(
                width: 10,
              ),
              Text(
                " Help and feedback",
                style: TextStyle(fontSize: 26),
              )
            ]),
      ),
    );
  }
}
