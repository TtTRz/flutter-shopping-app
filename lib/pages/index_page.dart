import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo/pages/feature/feature_page.dart';
import 'package:flutter_demo/service/user.dart';

import './cart/cart_page.dart';
import './category/category_page.dart';
import './home/home_page.dart';
import './user/user_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), label: "Category"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: "Cart"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.list_bullet), label: "Feature"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: "User")
  ];

  final List tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    FeaturePage(),
    UserPage(),
  ];
  int currentIndex = 0;

  var currentPage;

  @override
  void initState() {
    userWebLogin({"open_id": "om10q46ltMBS_c1g7div4mGBA6fU"}).then((val) {
      // setState(() {
      //   // homePageContent = val["id"].toString();
      // });
    });
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: currentPage,
    );
  }
}
