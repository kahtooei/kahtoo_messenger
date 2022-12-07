import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogsScreenState();
}

class LogsScreenState extends State<LogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Logs Screen")),
    );
  }
}
