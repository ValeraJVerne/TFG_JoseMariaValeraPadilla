import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  Function onClickedFunction;

  MenuButton(this.onClickedFunction);

  Widget build(BuildContext context) {
    return
      ElevatedButton(
      onPressed: () {
        onClickedFunction();
      },
      child: Icon(Icons.play_arrow),
      style: ElevatedButton.styleFrom(
          primary: Colors.greenAccent, //Color del boton de jugar
          fixedSize: const Size(250, 100),
          ),
    );
  }
}
