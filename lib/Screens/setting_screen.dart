import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Setting Screen")),
    );
  }
}
