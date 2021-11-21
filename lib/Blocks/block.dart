import '../point.dart';
import 'package:flutter/material.dart';
import '../game.dart';

class Block {
  List<Point> points = [Point(0, 0), Point(0, 1), Point(1, 1), Point(1, 0)];
  late Point rotationCenter;
  late Color color;

  void move(MoveDirection dir) {
    switch (dir) {
      case MoveDirection.RIGHT:
        if(isAbleToMoveAside(1)) {
          for (var element in points) {
            element.x += 1;
          }
        }
        break;
      case MoveDirection.LEFT:
        if(isAbleToMoveAside(-1)) {
          for (var element in points) {
            element.x -= 1;
          }
        }
        break;
      case MoveDirection.DOWN:
        for (var element in points) {
          element.y += 1;
        }
        break;
    }
  }

  bool isAbleToMoveAside(int movAsi){
    bool canMove = true;
    points.forEach((element) {
      if(element.x + movAsi < 0 || element.x + movAsi >= BOARD_WIDTH){
        canMove = false;
      }
    });

    return canMove;
  }

  bool isAllPointsInside(){
    bool isInside = true;

    points.forEach((element) {
      if(element.x < 0 || element.x >= BOARD_WIDTH){
        isInside = false;
      }
    });

    return isInside;
  }

  bool isAtBottom(){
    int bottomHeight = 0;

    points.forEach((element) {
      if(element.y > bottomHeight){
        bottomHeight = element.y;
      }
    });
    if(bottomHeight >= BOARD_HEIGHT - 1){
      return true;
    } else {
      return false;
    }
  }

  void rotate() {
      points.forEach((element) {
        int x = element.x;
        element.x = rotationCenter.x - element.y + rotationCenter.y;
        element.y = rotationCenter.y + x - rotationCenter.x;
      });

      if(isAllPointsInside() == false){
        rotate();
      }
  }
}