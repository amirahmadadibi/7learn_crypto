import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    print('init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('AmriahmadAdibi'),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'))
        ],
      )),
    );
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}
