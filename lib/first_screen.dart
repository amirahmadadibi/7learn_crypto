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
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
    Response response = await get(uri);
    String jsonTitle = jsonDecode(response.body)['title'];
    int jsonUserID = jsonDecode(response.body)['userId'];
    int jsonID = jsonDecode(response.body)['id'];
    bool jsonCompleted = jsonDecode(response.body)['completed'];
    setState(() {
      title = jsonTitle;
      userId = jsonUserID;
      id = jsonID;
      isDone = jsonCompleted;
    });
  }
}
