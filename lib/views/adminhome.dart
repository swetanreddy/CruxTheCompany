import 'package:com/helper/authenticate.dart';
import 'package:com/services/auth.dart';
import 'package:com/views/adminorders.dart';
import 'package:com/views/adminprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthMethods authMethods = new AuthMethods();
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Title(
          color: Colors.white,
          child: Text("CRUX",
            style: TextStyle(
                fontSize: 40,
            ),
          ),
        ),
      ),
      body: PageView(
        children: <Widget>[
          Orders(),
          AdminProfile()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FlutterIcons.list_bullet_fou)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle)
          ),
        ],
      ),
    );
  }
}
