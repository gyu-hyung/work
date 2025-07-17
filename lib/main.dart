import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(HiteenApp(navigatorKey: navigatorKey));
}
