import 'package:admin/controllers/Application.dart';
import 'package:admin/controllers/Session.dart';
import 'package:admin/router/AppRouter.gr.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    postDelayed(
        callbak: () {
          print("GOTO");
          if (Session.isLogedIn) {
            application.navigateRoot(MainRoute());
          } else {
            application.navigateReplace(LoginRoute(onLoginResult: (bool ) {  }));
          }
        },
        milliseconds: 10);
  }

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (BuildContext context) {
        return Scaffold(
            body: Container());
      },
    );
  }
}
