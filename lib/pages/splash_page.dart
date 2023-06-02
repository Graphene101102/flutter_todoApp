// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todoapp_03/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        checkLogin();
      },
    );
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => const HomePage(
                  title: 'Todos',
                )),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
              child: Image.asset(
                'assets/images/load.gif',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Positioned.fill(

          // ),
        ],
      ),
    );
  }
}
