import 'dart:async';

import 'package:flutter/material.dart';

class QuizTimer extends StatefulWidget {
  @override
  _QuizTimerState createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer> {
  int timer = 60;
  String showTimer = "60";

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
