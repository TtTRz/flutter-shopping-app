import "package:flutter/material.dart";
import 'package:flutter_demo/service/swiper.dart';
import '../../service/user.dart';
import '../../widgets/custom_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = "id";
  @override
  void initState() {
    // var data = {
    //   "city": "GuangZhou",
    //   "country": "China",
    //   "province": "GuangDong",
    //   "nickName": "Rom",
    // };
    // userRegister(data).then((val) {
    //   setState(() {
    //     homePageContent = val.id;
    //   });
    // });
    userWebLogin({"open_id": "om10q46ltMBS_c1g7div4mGBA6fU"}).then((val) {
      setState(() {
        // homePageContent = val["id"].toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Shopping Home")),
        // body: SingleChildScrollView(
        //   child: Text(homePageContent),
        // )
        body: FutureBuilder(
          future: swiperGoodsMget({
            "ids": [3, 7, 6],
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              print(data);
              List<Map> swiperDataList = [];
              // (data['data']['slides'] as List).cast();
              return Column(
                children: <Widget>[
                  CustomSwiper(swiperDataList: swiperDataList),
                ],
              );
            } else {
              return Center(child: Text("Swiper Loading..."));
            }
          },
        ));
  }
}
