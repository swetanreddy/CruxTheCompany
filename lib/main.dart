import 'package:com/helper/authenticate.dart';
import 'package:com/helper/helperfunctions.dart';
import 'package:com/views/adminhome.dart';
import 'package:com/views/companylogin.dart';
import 'package:com/views/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn;
  bool adminIsLoggedIn;

  @override
  void initState() {
    getUserLoggedInState();
    getAdminLoggedInState();
    super.initState();
  }

  getUserLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((val) {
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  getAdminLoggedInState() async {
    await HelperFunctions.getAdminLoggedInSharedPreference().then((val) {
      setState(() {
        adminIsLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ? userIsLoggedIn ? HomePage() : Authenticate() :
      adminIsLoggedIn != null ? adminIsLoggedIn ? AdminHome() : CompanyLogin() :Authenticate(),
    );
  }
}


