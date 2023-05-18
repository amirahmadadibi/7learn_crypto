import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String title = '';
  int userId = 0;
  int id = 0;
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('title -> $title'),
            Text('user id -> $userId'),
            Text('id -> $id'),
            Text((isDone) ? 'completed -> yes' : 'completed -> no'),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    title = 'loading...';
                  });
                  getData();
                },
                child: Text('Get Data From API'))
          ],
        ),
      ),
    );
  }

  Future<void> getData() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    Response response = await get(uri);

    for (int i = 0; i <= 199; i++) {
      String title = jsonDecode(response.body)[i]['title'];
      print(title);
    }
  }
}
