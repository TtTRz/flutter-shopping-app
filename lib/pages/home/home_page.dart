import "package:flutter/material.dart";
import 'package:flutter_demo/config/service_url.dart';
import 'package:flutter_demo/service/category.dart';
import 'package:flutter_demo/service/swiper.dart';
import 'package:flutter_demo/widgets/recommend_list.dart';
import 'package:flutter_demo/widgets/top_navigator.dart';
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
  List categoryList = [];
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
    userWebLogin({"open_id": "om10q46ltMBS_c1g7div4mGBA6fU"}).then((data) {
      categoryGetList(params: {"limit": 10, "page": 1, "parent_id": 0})
          .then((data) {
        var _data = json.decode(data.toString());
        List ids = [];
        _data["tags"].forEach((e) {
          ids.add(e["id"]);
        });
        categoryListMget(data: {"ids": ids}).then((data) {
          List _data = data.data;
          List _list = [];
          _data.forEach((e) {
            print(e);
            _list.add({
              "title": e["title"],
              "image": QINIU_BASR_URL + "/" + e["picture"],
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Shopping Home")),
        body: FutureBuilder(
          future: swiperGoodsMget({
            "ids": [3, 7, 6, 9],
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data.data;
              List swiperDataList = [];
              data.forEach((item) {
                swiperDataList
                    .add({"image": QINIU_BASR_URL + "/" + item["picture"]});
              });
              // return Center(child: Text("Swiper Loading..."));
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CustomSwiper(swiperDataList: swiperDataList),
                    TopNavigator(navigatorList: categoryList),
                    // RecommendList(),
                  ],
                ),
              );
            } else {
              return Center(child: Text("Swiper Loading..."));
            }
          },
        ));
  }
}
