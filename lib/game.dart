import 'package:flutter/material.dart';
import 'package:tetris_tfg/Blocks/block.dart';
import 'main.dart';
import 'action_button.dart';
import 'random.dart';
import 'dart:async';
import 'Blocks/block.dart';
import 'Blocks/fixed_point.dart';
import 'score_board.dart';
import 'package:audioplayers/audioplayers.dart';


enum ButtonPressed { LEFT, RIGHT, ROTATE, NONE }
enum MoveDirection { LEFT, RIGHT, DOWN }

const int BOARD_WIDTH = 10;
const int BOARD_HEIGHT = 20;

const double WIDTH = 200;
const double HEIGHT = 400;

const double POINT_SIZE = 20;

late Timer timer;
late Block currentBlock;

AudioCache musicPlayer = AudioCache();
const tetrisMusic = "Tetris-theme.mp3";

int speed = 400;
List<FixedPoint> fixedPoints = [];

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Playable();
}

class Playable extends State<Game> {
  ButtonPressed actionPerformed = ButtonPressed.NONE;
  int score = 0;


  @override
  void initState() {
    super.initState();
    playMusic();
    startGame();
  }


  void onButtonPressed(ButtonPressed newAction) {
    setState(() {
      actionPerformed = newAction;
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });
    timer = Timer.periodic(Duration(milliseconds: speed), onTimeTick);
  }


//Block-related code
  //Spawning / saving / accelerating block
  void onTimeTick(Timer time) {
    if (currentBlock == null || isGameLost()) return;

    removeFilledRows();

    if (currentBlock.isAtBottom() || isAboveExistingBlock()) {
      saveBlock();

      setState(() {
        currentBlock = getRandomBlock();
      });
    } else {
      setState(() {
        currentBlock.move(MoveDirection.DOWN);
      });
      checkForUserInput();
    }
  }

  //Drawing the block
  Widget? drawBlock() {
    if (currentBlock == null) return null;

    List<Positioned> visiblePoints = <Positioned>[];

    currentBlock.points.forEach((element) {
      Positioned newPoint = Positioned(
          child: getTetrisPoint(currentBlock.color),
          left: element.x * POINT_SIZE,
          top: element.y * POINT_SIZE);
      visiblePoints.add(newPoint);
    });

    fixedPoints.forEach((element) {
      visiblePoints.add(
        Positioned(
          child: getTetrisPoint(element.color),
          left: element.x * POINT_SIZE,
          top: element.y * POINT_SIZE,
        ),
      );
    });

    return Stack(children: visiblePoints);
  }

  //Collision Detection
  bool isAboveExistingBlock(){
    bool aboveBlock = false;

    fixedPoints.forEach((element) {
      if(element.isPointsCollide(currentBlock.points)){
        aboveBlock = true;
      }
    });

    return aboveBlock;
  }

  //Save current block
  void saveBlock() {
    currentBlock.points.forEach((element) {
      FixedPoint newPoint =
      FixedPoint(element.x, element.y, currentBlock.color);
      setState(() {
        fixedPoints.add(newPoint);
      });
    });
  }

  //Increase block speed
  void increaseSpeed(){
    timer.cancel();
    speed -= 30;
    timer = Timer.periodic(Duration(milliseconds: speed), onTimeTick);
  }

//Row-related code
  void removeRow(int row){
    setState(() {
      fixedPoints.removeWhere((element) => element.y == row);

      fixedPoints.forEach((element) {
        if(element.y < row){
          element.y += 1;
        }
      });

      score += 10;
      increaseSpeed();
    });
  }

  void removeFilledRows(){
    for(int row = 0; row < BOARD_HEIGHT; row++){
      int counter = 0;

      fixedPoints.forEach((element) {
        if(element.y == row){
          counter++;
        }
      });

      if(counter == BOARD_WIDTH){
        removeRow(row);
      }
    }
  }

//Game-related code
  //Movement
  void checkForUserInput() {
    if (actionPerformed != ButtonPressed.NONE) {
      setState(() {
        switch (actionPerformed) {
          case ButtonPressed.LEFT:
            currentBlock.move(MoveDirection.LEFT);
            break;
          case ButtonPressed.RIGHT:
            currentBlock.move(MoveDirection.RIGHT);
            break;
          case ButtonPressed.ROTATE:
            currentBlock.rotate();
            break;
          default:
            break;
        }
        actionPerformed = ButtonPressed.NONE;
      });
    }
  }

  //Game end
  bool isGameLost(){
    bool isLost = false;

    fixedPoints.forEach((element) {
      if(element.y <= 0){
        isLost=true;
      }
    });
    return isLost;
  }

  //Music
  void playMusic(){
    if(!musicPlaying) {
      musicPlayer.loop(tetrisMusic);
      musicPlaying=true;
    }
  }


//Player visible-related code
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: WIDTH,
              height: HEIGHT,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,style: BorderStyle.solid),
              ),
              child: (isGameLost() == false) ? drawBlock() : gameOver(score),
            ),
            ScoreBoard(score)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(
              onButtonPressed, //Mover a la izquiera
              Icon(Icons.arrow_left),
              ButtonPressed.LEFT,
            ),
            ActionButton(
              onButtonPressed, //Mover a la derecha
              Icon(Icons.arrow_right),
              ButtonPressed.RIGHT,
            ),
            ActionButton(
              onButtonPressed, //Girar
              Icon(Icons.rotate_right),
              ButtonPressed.ROTATE,
            ),
          ],
        ),
      ],
    );
  }
}
