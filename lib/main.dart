import 'package:flutter/material.dart';
import 'menu.dart';
import 'game.dart';

bool musicPlaying=false;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tetris",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Menu(),
    );
  }
}

class GameScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: () async{
            timer.cancel();
            Navigator.pop(context);
            fixedPoints.clear();
          },
              icon: new Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Game(),
    );
  }
}
