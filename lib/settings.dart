import 'package:flutter/material.dart';
import 'package:ncontroller/joystickview.dart';
import 'package:ncontroller/provider/customization.dart';
import 'package:ncontroller/widget/switch.dart';
import 'package:provider/provider.dart';

class SettingsPg extends StatefulWidget {
  const SettingsPg({super.key});

  @override
  State<SettingsPg> createState() => _SettingsPgState();
}
  bool keypad=false;
class _SettingsPgState extends State<SettingsPg> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Customization>(
        create: (_) => Customization(),
        builder: (context, child) {
          final settingsProvider = Provider.of<Customization>(context);
          keypad=settingsProvider.features["keypad"]!;
          return Scaffold(
            appBar: AppBar(
              title: Text("Settings"),
              centerTitle: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Wrap(
                      children: [
                        Cswitch(
                          text: 'Gesture support',
                          value: settingsProvider.getFeature('gesture'),
                          onChange: (bool value) {
                            settingsProvider.featureUpdate('gesture', value);
                          },
                        ),
                        Cswitch(
                          text: 'Gamepad mode',
                          value: settingsProvider.getFeature('gamepad'),
                          onChange: (bool value) {
                            settingsProvider.featureUpdate('gamepad', value);
                          },
                        ),
                        Cswitch(
                          text: 'Mouse mode',
                          value: settingsProvider.getFeature('mouse'),
                          onChange: (bool value) {
                            settingsProvider.featureUpdate('mouse', value);
                          },
                        ),
                        Cswitch(
                          text: 'Keypad',
                          value: keypad,
                          onChange: (bool value) {
                            settingsProvider.featureUpdate('keypad', value);
                          },
                        ),
                        Cswitch(
                          text: 'Beta',
                          value: settingsProvider.getFeature('beta'),
                          onChange: (bool value) {
                            settingsProvider.featureUpdate('beta', value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Directions",
                            style: TextStyle(fontSize: 20),
                          ),
                          Cswitch(
                            text: 'Gesture support',
                            value: settingsProvider.getFeature('gesture'),
                            onChange: (bool value) {
                              settingsProvider.featureUpdate('gesture', value);
                            },
                          ),
                          Cswitch(
                            text: 'Gamepad mode',
                            value: settingsProvider.getFeature('gamepad'),
                            onChange: (bool value) {
                              settingsProvider.featureUpdate('gamepad', value);
                            },
                          ),
                          Cswitch(
                            text: 'Mouse mode',
                            value: settingsProvider.getFeature('mouse'),
                            onChange: (bool value) {
                              settingsProvider.featureUpdate('mouse', value);
                            },
                          ),
                          Cswitch(
                            text: 'Keypad',
                            value: settingsProvider.getFeature('keypad'),
                            onChange: (bool value) {
                              settingsProvider.featureUpdate('keypad', value);
                            },
                          ),
                          Cswitch(
                            text: 'Beta',
                            value: settingsProvider.getFeature('beta'),
                            onChange: (bool value) {
                              settingsProvider.featureUpdate('beta', value);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          );
        });
  }
}
