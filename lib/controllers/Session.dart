import 'dart:ui';
import 'package:flutter/material.dart';

mixin Session {
  static String? mToken;
  static late Locale appLang = Locale('en');
  // static int selectedProfileId;
  static bool isLogedIn = false;
  // static const bool isUAT = false;
  static late List<String> menus;
}
