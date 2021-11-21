import "package:flutter/material.dart";
import 'main.dart';
import "menu_button.dart";

class Menu extends StatefulWidget {
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  void onPlayClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen()),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("menu-background.jpg"),
            fit: BoxFit.cover)
    ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Tetris',
            style: TextStyle(
                fontSize: 70.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 8.0,
                    offset: Offset(2.0, 2.0),
                  )
                ]),
          ),
          MenuButton(onPlayClick),
        ],
      ),
    );
  }
}
