import 'package:flutter/material.dart';
import 'package:ncontroller/game_controls.dart';
import 'package:ncontroller/provider/customization.dart';
import 'package:ncontroller/provider/multi_btn.dart';
import 'package:ncontroller/widget/small_button.dart';
import 'package:provider/provider.dart';

class GamePad extends StatelessWidget {
  GamePad({
    super.key,
//UP
    required this.labelUp,
    required this.Up_MesU,
    required this.Up_MesD,

//DOWN
    required this.labelDown,
    required this.Down_MesU,
    required this.Down_MesD,
//LEFT
    required this.labelLeft,
    required this.Left_MesU,
    required this.Left_MesD,

//RIGHT
    required this.labelRight,
    required this.Right_MesU,
    required this.Right_MesD,
  });

  //UP
  void Function() Up_MesU;
  void Function() Up_MesD;
  Widget? labelUp;

  //DOWN
  void Function() Down_MesU;
  void Function() Down_MesD;
  Widget? labelDown;

  //LEFT
  void Function() Right_MesU;
  void Function() Right_MesD;
  Widget? labelRight;

  //RIGHT
  void Function() Left_MesU;
  void Function() Left_MesD;
  Widget? labelLeft;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Customization>(
        create: (_) => Customization(),
        builder: (context, child) {
          final settingsProvider = Provider.of<Customization>(context);
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (settingsProvider.getFeature('gesture') == true && settingsProvider.getFeature('beta') == true) {
                double? displacement = details.primaryDelta;
                //print("hor: ${displacement}");

                if (displacement!.abs() > 1.99) {
                  // Check for minimum swipe distance
                  if (displacement > 3.99) {
                    print("Swiping left (real-time)");
                  } else if (displacement > -3.99) {
                    print("Swiping right (real-time)");
                  }
                }
              }
            },
            onHorizontalDragEnd: (details) {},
            onVerticalDragUpdate: (details) {
              if (settingsProvider.getFeature('gesture') == true &&
                  settingsProvider.getFeature('beta') == true) {
                double? displacementy = details.primaryDelta;
                //print("ver: ${displacementy}");

                if (displacementy!.abs() > 1.99) {
                  // Check for minimum swipe distance
                  if (displacementy > 3.99) {
                    print("Swiping down (real-time)");
                  } else if (displacementy > -3.99) {
                    print("Swiping up (real-time)");
                  }
                }
              }
            },
            onVerticalDragDown: (details) {},
            child: Container(
              width: sizeB,
              height: sizeB,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  // Up button
                  InsideB(
                    label: labelUp,
                    top: 0,
                    left: (sizeB - size) / 2,
                    messageUp: () {
                      //print('Up clicked down');
                      //client.sendMessage(messageDown);
                      Up_MesU();
                    },
                    messageDown: () {
                      Up_MesD();
                    },
                  ),
                  // Down button (similar positioning)
                  InsideB(
                    label: labelDown,
                    bottom: 0,
                    left: (sizeB - size) / 2,
                    messageUp: () {
                      Down_MesU();
                    },
                    messageDown: () {
                      Down_MesD();
                    },
                  ),
                  // Left button (similar positioning)
                  InsideB(
                    label: labelLeft,
                    left: 0,
                    top: (sizeB - size) / 2,
                    messageUp: () {
                      Left_MesU();
                    },
                    messageDown: () {
                      Left_MesD();
                    },
                  ),
                  InsideB(
                    label: labelRight,
                    right: 0,
                    top: (sizeB - size) / 2,
                    messageUp: () {
                      Right_MesU();
                    },
                    messageDown: () {
                      Right_MesD();
                    },
                  ),
                  // Right button (similar positioning)
                ],
              ),
            ),
          );
        });
  }
}
