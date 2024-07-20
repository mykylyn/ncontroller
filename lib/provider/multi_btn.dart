import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncontroller/tcp.dart';
import 'package:ncontroller/client.dart';
import 'dart:async';

class Multibtn extends ChangeNotifier {
  Tcp client = Tcp();

  Multibtn() {
    //client.startConnection();
    initialize();
  }

  String previousKey = "";
  String message = "";

  // You can also provide initial key-value pairs
  Map<String, bool> buttonStatus = {
    'upR': false,
    'downR': false,
    'rightR': false,
    'leftR': false,
    'upL': false,
    'downL': false,
    'rightL': false,
    'leftL': false,
    'Y': false,
    'X': false,
    'A': false,
    'B': false,
    'W': false,
    'Q': false,
    'E': false,
    'R': false,
    'upE': false,
    'downE': false,
    'rightE': false,
    'leftE': false,
  };

  Map<String, bool> widgetStatus = {
    "joystickR": false,
    "joystickL": false,
    "arR": false,
    "arL": false,
    "specialR": false,
    "specialL": false,
    "extra": false,
  };

  List<String> keysPrev = [];
  List<String> keysDown = [];
  List<String> keysUp = [];

  late double _xJ;
  late double _yJ;
  late List<String> directionsJ;
  String curdir = "";
  String Joystatus = "";

  void initialize() {
    client.connect();
    //client.establish();
    //tcp.connect();
  }

  void close() {
    //tcp.close();
  }

  Future<void> joyStickUpdate(String id, double _x, double _y) async {
    this._xJ = _x;
    this._yJ = _y;

    String curMes = "";

    if (_yJ.abs() > _xJ.abs()) {
      notifyListeners();
      if (_yJ > .10) {
        //widgetStatus["joystick${id}"] = true;
        curMes = "down${id}";
        buttonStatus[curMes] = true; //need to be according to the assigned

        print("$curMes = ${buttonStatus[curMes]}");
      } else if (_yJ < -.10) {
        //widgetStatus["joystick${id}"] = true;
        curMes = "up${id}";
        buttonStatus[curMes] = true; //need to be according to the assigned

        print("$curMes = ${buttonStatus[curMes]}");
      }
    } else if (_xJ.abs() > _yJ.abs()) {
      if (_xJ > .10) {
        //widgetStatus["joystick${id}"] = true;
        curMes = "right${id}";
        buttonStatus[curMes] = true;
        //need to be according to the assigned

        print("$curMes = ${buttonStatus[curMes]}");
      } else if (_xJ < .10) {
        //widgetStatus["joystick${id}"] = true;
        curMes = "left${id}";
        buttonStatus[curMes] = true; //need to be according to the assigned

        print("$curMes = ${buttonStatus[curMes]}");
      }
    }

    if (_xJ == 0 || _yJ == 0) {
      //print("at zero$id");
      //buttonStatus[curMes] = false;
      print("$curMes = ${buttonStatus[curMes]}");
      curMes = "";
      //widgetStatus["joystick${id}"] = false;
      notifyListeners();
    }

    return Future.value();
  }

  void arrowKeysUpdate(
    String id,
    String name,
    bool state,
  ) {
    widgetStatus["ar${id}"] = state;
    buttonStatus["${name}${id}"] = state; //need to be according to the assigned
    print("${name}${id} == $state");
    notifyListeners();
  }

  void specialBtnUpdate(
    String id,
    bool state,
  ) {
    buttonStatus["${id}"] = state;
    print("${id} == $state");
    //print(buttonStatus["${id}"]);
    notifyListeners();
  }

  Future<void> Send() async {
    //client.sendMessage(buttonStatus);
    print("sent");
    await client.sendMessage(buttonStatus);
  }
}
