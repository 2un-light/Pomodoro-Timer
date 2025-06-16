import 'package:flutter/material.dart';

class AppTheme {
  final String name;
  final Color backgroundColor;
  final Color focusColor;
  final Color shortBreakColor;
  final Color longBreakColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  const AppTheme({
    required this.name,
    required this.backgroundColor,
    required this.focusColor,
    required this.shortBreakColor,
    required this.longBreakColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });
}