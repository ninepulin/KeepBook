import 'dart:async';
import 'package:flutter/material.dart';
import 'Login.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Main',
      home: LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyLoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 125, 161, 197),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: const Color.fromARGB(255, 218, 171, 171),
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  scale: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/logo2.png',
              scale: 2,
            ),
            const SizedBox(height: 10),
            const Text(
              'Your book is always with you',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
