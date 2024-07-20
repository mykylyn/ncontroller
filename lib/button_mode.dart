import 'dart:async';

import 'package:flutter/material.dart';
import 'client.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = Client('ipaddress', 1234);
  @override
  void initState() {
    super.initState();
    client.establish();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Timer? _timer;

  bool _isPressed = false;
  double s = 1.0;

  double roundness = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF000906),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTapDown: (details) {
                    print('Down clicked down');
                    //client.sendMessage("DownD");
                  },
                  onTapUp: (details) {
                    print('Down clicked down');
                    //client.sendMessage("DownU");
                  },
                  onTapCancel: () {
                    print('Down clicked cancel');
                    //client.sendMessage("DownU");
                  },
                  onDoubleTap: () {
                    //print('Space clicked');
                    //client.sendMessage("DownD");
                  },
                  child: ButtonC(
                    name: "Down",
                    icon: Icons.arrow_downward_rounded,
                    isPressed: _isPressed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(roundness),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: GestureDetector(
                  onLongPressDown: (details) {
                    print('Left clicked down');
                    //client.sendMessage("LeftD");
                  },
                  onLongPressUp: () {
                    print('Left clicked down');
                    //client.sendMessage("LeftU");
                  },
                  onLongPressCancel: () {
                    print('Left clicked down');
                    //client.sendMessage("LeftU");
                  },
                  onDoubleTap: () {
                    //print('Space clicked');
                    //client.sendMessage("LeftD");
                  },
                  child: ButtonC(
                    name: "Left",
                    icon: Icons.turn_left_rounded,
                    isPressed: _isPressed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(roundness),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //ToggleButtons(children: children, isSelected: isSelected)
                  const Center(
                    child: Text(
                      "Angle",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onLongPressDown: (details) {
                      print('Space clicked');
                      //client.sendMessage("SpaceD");
                    },
                    onLongPressUp: () {
                      print('Space clicked');
                      //client.sendMessage("SpaceU");
                    },
                    onLongPressCancel: () {
                      print('Space clicked');
                      //client.sendMessage("SpaceU");
                    },

                    /*
                                onTapDown: (details) {
                  print('Space clicked down');
                  client.sendMessage("SpaceD");
                                },
                                onTapUp: (details) {
                  print('Down clicked down');
                  client.sendMessage("SpaceU");
                                },
                                onTapCancel: () {
                  print('Down clicked cancel');
                  client.sendMessage("SpaceU");
                                },
                                */
                    onDoubleTap: () {
                      //print('Space clicked');
                      //client.sendMessage("Space");
                    },
                    child: ButtonC(
                      name: "Space",
                      icon: Icons.space_bar_rounded,
                      isPressed: _isPressed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(roundness),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(width: 15.0),
              Expanded(
                child: GestureDetector(
                    onTapDown: (details) {
                      print('Up clicked down');
                      //client.sendMessage("UpD");
                    },
                    onTapUp: (details) {
                      print('Up clicked down');
                      //client.sendMessage("UpU");
                    },
                    onTapCancel: () {
                      print('Up clicked cancel');
                      //client.sendMessage("UpU");
                    },
                    onDoubleTap: () {
                      //print('Space clicked');
                      //client.sendMessage("UpD");
                    },
                    child: ButtonC(
                      icon: Icons.arrow_upward_rounded,
                      name: 'Up',
                      isPressed: _isPressed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(roundness),
                      ),
                    )),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: GestureDetector(
                  onLongPressDown: (details) {
                    print('Right clicked down');
                    //client.sendMessage("RightD");
                    setState(() {
                      _isPressed = false;
                      s = 1;
                    });
                  },
                  onLongPressUp: () {
                    print('Right clicked down');
                    //client.sendMessage("RightU");
                    setState(() {
                      _isPressed = true;
                      s = 0.7;
                    });
                  },
                  onLongPressCancel: () {
                    print('Right clicked down');
                    //client.sendMessage("RightU");
                    setState(() {
                      _isPressed = true;
                      s = 0.7;
                    });
                  },
                  onTapDown: (details) {
                    setState(() {
                      _isPressed = false;
                      s = 1;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      _isPressed = true;
                      s = 0.7;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _isPressed = true;
                      s = 0.7;
                    });
                  },
                  onDoubleTap: () {
                    //print('Space clicked');
                    //client.sendMessage("RightD");
                  },
                  child: ButtonC(
                    isPressed: _isPressed,
                    name: 'Right',
                    icon: Icons.turn_right_rounded,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(roundness),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonC extends StatelessWidget {
  ButtonC({
    super.key,
    required this.name,
    required this.icon,
    required this.isPressed,
    required this.shape,
  });

  String name;

  bool isPressed;

  IconData icon;

  ShapeBorder shape = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: isPressed ? 150 : 145,
      height: isPressed ? 150 : 145,
      //transform: _isPressed ? (Matrix4.identity()..scale(0.9)) : Matrix4.identity(),
      decoration: ShapeDecoration(color: const Color(0xFFC1DDD3), shape: shape),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 90),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
