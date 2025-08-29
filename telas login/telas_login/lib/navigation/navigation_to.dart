import 'package:flutter/material.dart';

class NavigationTo {
  void navigationTo(String route, BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }
}
