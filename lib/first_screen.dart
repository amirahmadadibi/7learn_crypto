import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lifecycle/crypto.dart';
import 'package:lifecycle/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Crypto> cryptoList = [];
  bool isLoading = false;
  String title = '7Learn Crypto Application';
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          toolbarHeight: 200,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 70,
                    width: 200,
                    child: Image.asset('assets/images/logo.png')),
                SizedBox(
                  height: 30,
                ),
                Visibility(visible: isLoading, child: Text('Loading...')),
                Visibility(
                  visible: !isLoading,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset('assets/images/search.png'),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),

        // // AppBar(
        // //   title: Text((isLoading) ? 'Loading...' : title),
        // //   centerTitle: true,
        // //   backgroundColor: Color(0xff03C988),
        // // ),
        body: RefreshIndicator(
          onRefresh: () async {
            getData();
          },
          child: ListView.builder(
            itemCount: cryptoList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 85,
                margin: EdgeInsets.only(bottom: 10, left: 25, right: 25),
                color: Color(0xffffffff),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          width: 45,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://assets.coincap.io/assets/icons/${cryptoList[index].symbol.toLowerCase()}@2x.png',
                            placeholder: (context, url) {
                              return Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xff1C82AD),
                                    borderRadius: BorderRadius.circular(12)),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cutDownCryptoName(cryptoList[index].name),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            SizedBox(
                              height: 8,
                            ),
                            Text(cryptoList[index].symbol,
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xffAAB0BD))),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                '\$${cryptoList[index].priceUSD.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Row(
                              children: [
                                getArraowWidget(
                                    cryptoList[index].changeInPersent),
                                Text(
                                    "\$ " +
                                        cryptoList[index]
                                            .changeInPersent
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            (cryptoList[index].changeInPersent <
                                                    0)
                                                ? Colors.red
                                                : Colors.green)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 0.5,
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget getArraowWidget(double changeInPersent) {
    if (changeInPersent < 0) {
      return Icon(
        Icons.arrow_downward,
        color: Colors.red,
        size: 15,
      );
    } else {
      return Icon(
        Icons.arrow_upward,
        color: Colors.green,
        size: 15,
      );
    }
  }

  Future<void> getData() async {
    var dio = Dio();
    setState(() {
      isLoading = true;
    });
    var response = await dio.get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptoDataList =
        response.data['data'].map<Crypto>((jsonMapObject) {
      return Crypto.fromJson(jsonMapObject);
    }).toList();

    setState(() {
      isLoading = false;
      cryptoList = cryptoDataList;
    });
  }

  String cutDownCryptoName(String cryptoName) {
    if (cryptoName.length > 15) {
      var cuted = cryptoName.substring(0, 12);
      return '$cuted...';
    }
    return cryptoName;
  }
}
