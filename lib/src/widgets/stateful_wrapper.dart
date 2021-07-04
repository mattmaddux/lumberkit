import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  bool _alreadyRan = false;

  void run() {
    if (_alreadyRan) return;
    _alreadyRan = true;
    widget.onInit();
  }

  @override
  void initState() {
    super.initState();
    run();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
