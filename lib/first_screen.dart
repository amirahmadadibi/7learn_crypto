import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lifecycle/user.dart';

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
    var dio = Dio();
    var response =
        await dio.get('https://jsonplaceholder.typicode.com/users/1');
    Map<String, dynamic> data = response.data;
    User user1 = User.fromJson(data);
    print(user1.id);
    print(user1.username);
    print(user1.city);
  }
}
