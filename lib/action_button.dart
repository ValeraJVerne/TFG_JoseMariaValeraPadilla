import 'package:flutter/material.dart';
import 'game.dart';

class ActionButton extends StatelessWidget {
  Function onClickedFunction;
  Icon buttonIcon;
  ButtonPressed nextAction;

  ActionButton(this.onClickedFunction, this.buttonIcon, this.nextAction);

  Widget build(BuildContext context) {
    return ButtonTheme(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                onClickedFunction(nextAction);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: buttonIcon,
            )));
  }
}
