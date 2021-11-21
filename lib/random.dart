import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';
import 'game.dart';
import 'Blocks/block.dart';
import 'Blocks/c_block.dart';
import 'Blocks/i_block.dart';
import 'Blocks/j_block.dart';
import 'Blocks/l_block.dart';
import 'Blocks/s_block.dart';
import 'Blocks/t_block.dart';
import 'Blocks/z_block.dart';

Block getRandomBlock() {
  int randomNumber = Random().nextInt(7);
  late Block point;
  switch (randomNumber) {
    case 0:
      point = CBlock(BOARD_WIDTH);
      break;
    case 1:
      point = IBlock(BOARD_WIDTH);
      break;
    case 2:
      point = JBlock(BOARD_WIDTH);
      break;
    case 3:
      point = LBlock(BOARD_WIDTH);
      break;
    case 4:
      point = SBlock(BOARD_WIDTH);
      break;
    case 5:
      point = TBlock(BOARD_WIDTH);
      break;
    case 6:
      point = ZBlock(BOARD_WIDTH);
      break;
  }
  return point;
}

Widget getTetrisPoint(Color color) {
  return Container(
    width: POINT_SIZE,
    height: POINT_SIZE,
    decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
  );
}

Widget gameOver(int score) {
  return Center(
    child: Text(
      "Game Over\nFinal Score: $score",
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
          shadows: [
            Shadow(
                color: Colors.black,
                blurRadius: 4.0,
                offset: Offset(2.0, 2.0),)
          ]),
    ),
  );
}
