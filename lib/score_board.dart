import 'package:flutter/material.dart';


class ScoreBoard extends StatelessWidget {
  final int score;

  ScoreBoard(this.score);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.amber),
          borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
        ),
        child: Text(
          "Score\n$score",
          textAlign: TextAlign.center,
          style: (TextStyle(color: Colors.yellow, fontSize: 20)),
        ));
  }
}
