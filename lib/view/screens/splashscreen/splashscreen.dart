import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_craft_control/services/firebase/auth_service.dart';
import 'package:time_craft_control/view/core/const_datas.dart';
import 'package:time_craft_control/view/screens/home/home.dart';

class SplashScreen extends StatelessWidget {
  static const routename = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return SafeArea(
      child: Scaffold(
        body: Center(child: Image.asset('assets/images/logo.png')),
      ),
    );
  }

  wait(BuildContext context) async {
    bool loggedIn = await AuthService().adminSignIn(email: email, password: password);
    Timer(
      const Duration(milliseconds: 2000),
      () {
        if (loggedIn) {
          Navigator.of(context).pushReplacementNamed(MyHome.routename);
        } else {
          Navigator.of(context).pushReplacementNamed('error');
        }
      },
    );
  }
}
