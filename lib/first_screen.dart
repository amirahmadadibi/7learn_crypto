import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle/crypto.dart';
import 'package:lifecycle/user.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Crypto> cryptoList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          color: Colors.red,
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            cryptoList[index].name,
            style: TextStyle(fontSize: 30),
          ),
        );
      },
    ));
  }

  Future<void> getData() async {
    var dio = Dio();
    var response = await dio.get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptoDataList =  response.data['data'].map<Crypto>((jsonMapObject) {
      return Crypto.fromJson(jsonMapObject);
    }).toList();
   
    setState(() {
      cryptoList = cryptoDataList;
    });
  }
}
