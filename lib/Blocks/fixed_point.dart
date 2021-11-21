import 'package:tetris_tfg/point.dart';
import 'package:flutter/material.dart';

class FixedPoint extends Point {
  Color color;

  FixedPoint(int x, int y, this.color) : super(x, y);


  bool isPointsCollide(List<Point> pointList) {
    bool isCollide = false;

    pointList.forEach((element) {
      if (element.x == x && element.y == y - 1) {
        isCollide = true;
      }
    });
    return isCollide;
  }
}