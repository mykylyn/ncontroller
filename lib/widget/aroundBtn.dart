import 'package:flutter/material.dart';
import 'package:ncontroller/game_controls.dart';

class SpecialBtn extends StatelessWidget {
  SpecialBtn({
    super.key,
    required this.textUp,
    required this.direction,
    required this.Up_messageUp,
    required this.Up_messageDown,
    required this.textDown,
    required this.Down_messageUp,
    required this.Down_messageDown,
  });

  Axis direction;

  String textUp;
  void Function() Up_messageUp;
  void Function() Up_messageDown;

  String textDown;
  void Function() Down_messageUp;
  void Function() Down_messageDown;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: direction,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onLongPressDown: (details) {
            Up_messageDown();
          },
          onLongPressUp: () {
            Up_messageUp();
          },
         
          onTapUp: (details) {
            Up_messageUp();
          },
         
          child: Container(
            width: sizeB / 2,
            height: sizeB / 2,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25.0), // Adjust as desired
            ),
            child: Center(
                child: Text(textUp,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900))),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onLongPressDown: (details) {
            Down_messageDown();
          },
          onLongPressUp: () {
            Down_messageUp();
          },
          onLongPressCancel: () {
            Down_messageUp();
          },
          onTapCancel: () {
            //print("onTap cancel");
            Down_messageUp();
          },
          onTapUp: (details) {
            Down_messageUp();
          },
          child: Container(
            width: sizeB / 2,
            height: sizeB / 2,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25.0), // Adjust as desired
            ),
            child: Center(
                child: Text(textDown,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900))),
          ),
        ),
      ],
    );
  }
}
