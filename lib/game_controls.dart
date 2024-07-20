import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:material_theme_builder/material_theme_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncontroller/provider/customization.dart';
import 'package:ncontroller/settings.dart';
import 'package:ncontroller/widget/gamepad.dart';
import 'package:ncontroller/widget/small_button.dart';
import 'package:ncontroller/widget/switch.dart';
import 'package:ncontroller/provider/multi_btn.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'tcp.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'client.dart';
import 'package:ncontroller/widget/aroundBtn.dart';

class Joystickview extends StatefulWidget {
  const Joystickview({super.key});

  @override
  State<Joystickview> createState() => _JoystickviewState();
}

double sizeB = 230;
double sizeBJ = sizeB * 0.8;
double size = sizeB / 2.5;

class _JoystickviewState extends State<Joystickview> {
  @override
  void initState() {
    super.initState();
    //Provider.of<Multibtn>(context, listen: false).initialize();
  }

  @override
  void dispose() {
    //Provider.of<Multibtn>(context, listen: false).close();
    super.dispose();
  }

  double step = 10.0;
  double dx = 0;
  double dy = 0;
  double _x = 0;
  double _y = 0;

  IconData down = FontAwesomeIcons.arrowDown;
  IconData up = FontAwesomeIcons.arrowUp;
  IconData left = FontAwesomeIcons.arrowLeft;
  IconData right = FontAwesomeIcons.arrowRight;

  double clamp(double value, double lowerBound, double upperBound) {
    return value < lowerBound
        ? lowerBound
        : (value > upperBound ? upperBound : value);
  }

  List<String> directions = ["Up", "Down", "Right", "Left"];
  String swipe = "";
  Offset _offset = Offset(100, 100); // Initial position of the container

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Multibtn(),
        ),
        ChangeNotifierProvider(
          create: (_) => Customization(),
        ),
      ],
      builder: (context, child) {
        final buttonProvider = Provider.of<Multibtn>(context);
        final settingsProvider = Provider.of<Customization>(context);
        

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
              title: Text("Controlpad"),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              centerTitle: true,
              actions: [
                PopupMenuButton<int>(
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Text("Settings"),
                          ),
                        ])
              ]),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "data",
                            style: TextStyle(fontSize: 35),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SpecialBtn(
                                textUp: "W",
                                Up_messageUp: () {
                                  ////print("i am up");
                                  //print("w");
                                  buttonProvider.specialBtnUpdate("W", false);
                                  buttonProvider.Send();
                                },
                                Up_messageDown: () {
                                  ////print("i am down");
                                  //print("w");
                                  buttonProvider.specialBtnUpdate("W", true);
                                  buttonProvider.Send();
                                },
                                textDown: "Q",
                                Down_messageUp: () {
                                  //print("Q");
                                  buttonProvider.specialBtnUpdate("Q", false);
                                  buttonProvider.Send();
                                },
                                Down_messageDown: () {
                                  //print("Q");
                                  buttonProvider.specialBtnUpdate("Q", true);
                                  buttonProvider.Send();
                                },
                                direction: Axis.horizontal,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  settingsProvider.getFeature('keypad')
                                      ? GamePad(
                                          //UP
                                          labelUp: Center(
                                            child: Icon(up),
                                          ),

                                          Up_MesU: () {
                                            ////print('Up clicked down');
                                            //client.sendMessage(messageDown);
                                            ////print('Up clicked down');
                                            //client.sendMessage(messageDown);
                                            //print("Up");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);

                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "up", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Up_MesD: () {
                                            //print("Up");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "up", true);
                                              buttonProvider.Send();
                                            }
                                          },

                                          labelDown: Center(
                                            child: Icon(down),
                                          ),

                                          Down_MesU: () {
                                            //print("down");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked up');
                                              //client.sendMessage(messageUp);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "down", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Down_MesD: () {
                                            //print("down");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "down", true);
                                              buttonProvider.Send();
                                            }
                                          },

                                          labelRight: Center(
                                            child: Icon(right),
                                          ),

                                          Right_MesU: () {
                                            //print("right");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "right", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Right_MesD: () {
                                            //print("right");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "right", true);
                                              buttonProvider.Send();
                                            }
                                          },

                                          labelLeft: Center(
                                            child: Icon(left),
                                          ),

                                          Left_MesU: () {
                                            //print("left");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "left", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Left_MesD: () {
                                            //print("left");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "L", "left", true);
                                              buttonProvider.Send();
                                            }
                                          },
                                        )
                                      : Joystick(
                                          mode: JoystickMode
                                              .horizontalAndVertical,
                                          stick: const CircleAvatar(
                                            radius: 30,
                                          ),
                                          base: Container(
                                            width: sizeBJ,
                                            height: sizeBJ,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          listener: (details) {
                                            _x = details.x;
                                            _y = details.y;

                                            buttonProvider.joyStickUpdate(
                                              "L",
                                              _x,
                                              _y,
                                            );
                                            buttonProvider.Send();
                                          },
                                        ),
                                  SpecialBtn(
                                    textUp: "Y",
                                    direction: Axis.vertical,
                                    Up_messageUp: () {
                                      ////print("i am up");
                                      buttonProvider.specialBtnUpdate(
                                          "Y", false);
                                      buttonProvider.Send();
                                    },
                                    Up_messageDown: () {
                                      ////print("i am down");
                                      buttonProvider.specialBtnUpdate(
                                          "Y", true);
                                      buttonProvider.Send();
                                    },
                                    textDown: "X",
                                    Down_messageUp: () {
                                      buttonProvider.specialBtnUpdate(
                                          "X", false);
                                      buttonProvider.Send();
                                    },
                                    Down_messageDown: () {
                                      buttonProvider.specialBtnUpdate(
                                          "X", true);
                                      buttonProvider.Send();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  buttonProvider.initialize();
                                },
                                child: Text(
                                  "Connect",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.green),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextButton(
                                onPressed: () {
                                  buttonProvider.close();
                                },
                                child: Text("Disconnect",
                                    style: TextStyle(fontSize: 20)),
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.red),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SpecialBtn(
                                direction: Axis.horizontal,
                                textUp: "A",
                                Up_messageUp: () {
                                  //print("A");
                                  buttonProvider.specialBtnUpdate("A", false);
                                  buttonProvider.Send();
                                },
                                Up_messageDown: () {
                                  //print("A");
                                  buttonProvider.specialBtnUpdate("A", true);
                                  buttonProvider.Send();
                                },
                                textDown: "B",
                                Down_messageUp: () {
                                  //print("B");
                                  buttonProvider.specialBtnUpdate("B", false);
                                  buttonProvider.Send();
                                },
                                Down_messageDown: () {
                                  //print("B");
                                  buttonProvider.specialBtnUpdate("B", true);
                                  buttonProvider.Send();
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SpecialBtn(
                                    direction: Axis.vertical,
                                    textUp: "E",
                                    Up_messageUp: () {
                                      //print("E");
                                      buttonProvider.specialBtnUpdate(
                                          "E", false);
                                      buttonProvider.Send();
                                    },
                                    Up_messageDown: () {
                                      //print("E");
                                      buttonProvider.specialBtnUpdate(
                                          "E", true);
                                      buttonProvider.Send();
                                    },
                                    textDown: "R",
                                    Down_messageUp: () {
                                      //print("R");
                                      buttonProvider.specialBtnUpdate(
                                          "R", false);
                                      buttonProvider.Send();
                                    },
                                    Down_messageDown: () {
                                      //print("R");
                                      buttonProvider.specialBtnUpdate(
                                          "R", true);
                                      buttonProvider.Send();
                                    },
                                  ),
                                  settingsProvider.getFeature('keypad')
                                      ? GamePad(
                                          //UP
                                          labelUp: Center(
                                            child: Icon(up),
                                          ),

                                          Up_MesU: () {
                                            ////print('Up clicked down');
                                            //client.sendMessage(messageDown);
                                            ////print('Up clicked down');
                                            //client.sendMessage(messageDown);
                                            //print("Up");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "up", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Up_MesD: () {
                                            //print("Up");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "up", true);
                                              buttonProvider.Send();
                                            }
                                          },

                                          labelDown: Center(
                                            child: Icon(down),
                                          ),

                                          Down_MesU: () {
                                            //print("down");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked up');
                                              //client.sendMessage(messageUp);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "down", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Down_MesD: () {
                                            //print("down");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "down", true);
                                              buttonProvider.Send();
                                            }
                                          },

                                          labelRight: Center(
                                            child: Icon(right),
                                          ),

                                          Right_MesU: () {
                                            //print("right");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "right", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Right_MesD: () {
                                            //print("right");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "right", true);
                                              buttonProvider.Send();
                                            }
                                          },

                                          labelLeft: Center(
                                            child: Icon(left),
                                          ),

                                          Left_MesU: () {
                                            //print("left");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "left", false);
                                              buttonProvider.Send();
                                            }
                                          },
                                          Left_MesD: () {
                                            //print("left");
                                            if (settingsProvider
                                                    .getFeature('gesture') ==
                                                false) {
                                              ////print('${text} clicked down');
                                              //client.sendMessage(messageDown);
                                              buttonProvider.arrowKeysUpdate(
                                                  "R", "left", true);
                                              buttonProvider.Send();
                                            }
                                          },
                                        )
                                      : Joystick(
                                          mode: JoystickMode
                                              .horizontalAndVertical,
                                          stick: const CircleAvatar(
                                            radius: 30,
                                          ),
                                          base: Container(
                                            width: sizeBJ,
                                            height: sizeBJ,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          listener: (details) {
                                            _x = details.x;
                                            _y = details.y;

                                            buttonProvider.joyStickUpdate(
                                              "R",
                                              _x,
                                              _y,
                                            );
                                            buttonProvider.Send();
                                          },
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SettingsPg()));
      break;
  }
}
