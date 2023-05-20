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
  List<User> userList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          color: Colors.red,
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            userList[index].name,
            style: TextStyle(fontSize: 30),
          ),
        );
      },
    ));
  }

  Future<void> getData() async {
    var dio = Dio();
    var response = await dio.get('https://jsonplaceholder.typicode.com/users');
    //response.data List<Map<Stirng,dynamic>>
    List<User> userDataList = response.data.map<User>((jsonMapObject) {
      return User.fromJson(jsonMapObject);
    }).toList();

    setState(() {
      userList = userDataList;
    });
  }
}
