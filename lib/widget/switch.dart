import 'package:flutter/material.dart';


class Cswitch extends StatelessWidget {
   Cswitch(
      {super.key,
      required this.text,
      required this.value,
      required this.onChange});
  String text;
  bool value;
  Function(bool)? onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Switch(
          // This bool value toggles the switch.
          value: value,
          activeColor: Colors.green,
          onChanged: onChange,
        ),
      ],
    );
  }
}
