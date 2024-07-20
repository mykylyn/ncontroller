import 'package:flutter/foundation.dart';

class Customization extends ChangeNotifier {
  bool gesture = false;
  bool mouse = false;
  bool gamepad = false;
  bool keypad = true;
  bool beta = false;

  Map<String, bool> features = {
    'gesture': false,
    'mouse': false,
    'gamepad': false,
    'keypad': true,
    'beta': false,
  };

  Map<String, String> letters = {
    'Y': 'Y',
    'X': 'X',
    'A': 'A',
    'B': 'B',
    'W': 'W',
    'Q': 'Q',
    'E': 'E',
    'R': 'R',
  };

  void featureUpdate(String name, bool state) {
    features.forEach((key, value) {
      if (name == key) {
        print("${features[name]} == $state");
        features[name] = state;
      } else {
        features[name] = value;
      }
    });
    //print("when clicked");
    //print("${name} = ${state}");
  }

  bool getFeature(String name) {
    bool state = false;
    features.forEach((key, value) {
      if (name == key) {
        state = value;
      }
    });
    //print("get feature");
    //print("${name} = ${state}");
    return state;
  }

  void setName(String name, String display) {
    letters.forEach((key, value) {
      if (name == key) {
        letters[name] = display;
      } else {
        letters[name] = value;
      }
    });
  }

  String getName(String name) {
    String give = "";
    letters.forEach((key, value) {
      if (name == key) {
        give = value;
      }
    });
    return give;
  }
}
