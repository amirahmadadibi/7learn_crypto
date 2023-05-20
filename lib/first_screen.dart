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
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                '${cryptoList[index].rank}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                height: 50,
                width: 50,
                child: Image.network(
                    'https://assets.coincap.io/assets/icons/${cryptoList[index].symbol.toLowerCase()}@2x.png'),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cryptoList[index].name, style: TextStyle(fontSize: 20)),
                  Text(cryptoList[index].symbol,
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cryptoList[index].priceUSD.toStringAsFixed(2),
                      style: TextStyle(fontSize: 20)),
                  Text(cryptoList[index].changeInPersent.toStringAsFixed(2),
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              SizedBox(
                width: 8,
              ),
            ],
          ),
        );
      },
    ));
  }

  Future<void> getData() async {
    var dio = Dio();
    var response = await dio.get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptoDataList =
        response.data['data'].map<Crypto>((jsonMapObject) {
      return Crypto.fromJson(jsonMapObject);
    }).toList();

    setState(() {
      cryptoList = cryptoDataList;
    });
  }
}
