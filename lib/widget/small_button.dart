import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ncontroller/game_controls.dart';

class InsideB extends StatelessWidget {
  InsideB({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.label,
    required this.messageUp,
    required this.messageDown,
  });

  double? left;
  double? top;
  double? right;
  double? bottom;
  Widget? label;
  void Function() messageUp;
  void Function() messageDown;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left, // Centered placement
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onLongPressDown: (details) {
          //print("onLongTap down");
          messageDown();
        },
        onLongPressUp: () {
          //print("onLongTap up");
          messageUp();
        },
        
        onTapUp: (details) {
          //print("onTap up");
          messageUp();
        },
        
        //onTapCancel: longPressUp,
        //onLongPressEnd: longPressUp,
        /*
        onLongPressCancel: () {
          //print('${text} clicked down cancel');
          client.sendMessage(messageDown);
        },
        */
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(4278203965),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: label,
          ),
        ),
      ),
    );
  }
}
