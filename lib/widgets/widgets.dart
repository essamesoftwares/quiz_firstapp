import 'dart:async';

import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Qu',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
        TextSpan(
            text: 'iz',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
      ],
    ),
  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: buttonWidth != null
        ? buttonWidth
        : MediaQuery.of(context).size.width - 40,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget redButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        color: Colors.red, borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: buttonWidth != null
        ? buttonWidth
        : MediaQuery.of(context).size.width - 40,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget indigoButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        color: Colors.indigo, borderRadius: BorderRadius.circular(30)),
    alignment: Alignment.center,
    width: buttonWidth != null
        ? buttonWidth
        : MediaQuery.of(context).size.width - 40,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

class QuizTimer extends StatefulWidget {
  @override
  _QuizTimerState createState() => _QuizTimerState();
}

int timer = 60;
String showTimer = "60";

class _QuizTimerState extends State<QuizTimer> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          // MaterialPageRoute(
          //     builder: (context) => Results(
          //           correct: _correct,
          //           incorrect: _incorrect,
          //           total: total,
          //         ));
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget bottomNavigationBar(BuildContext context) {
  return Text(
    showTimer,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 48,
    ),
  );
}
