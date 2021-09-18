import 'package:app_marvel/config/di/di.dart';
import 'package:app_marvel/src/app_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependencies();
  runApp(const AppWidget());
}
