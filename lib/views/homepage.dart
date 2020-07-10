import 'package:com/helper/authenticate.dart';
import 'package:com/helper/constants.dart';
import 'package:com/helper/helperfunctions.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:com/views/userprofile.dart';
import 'package:com/views/settings.dart';
import 'package:com/results/busresults.dart';
import 'package:com/results/cabresults.dart';
import 'package:com/results/packersresults.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    getUserName();
    getUserEmail();
    super.initState();
  }

  getUserName() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getUserByUsername(Constants.myName).then((val) {
      setState(() {
        val;
      });
    });
    setState(() {

    });
  }

  getUserEmail() async {
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    databaseMethods.getUserByUserEmail(Constants.myEmail).then((val) {
      setState(() {
        val;
      });
    });
    setState(() {

    });
  }

  String purpose_id;
  List<String> purpose = [
    "Packers & Movers",
    "Bus Rental",
    "Cab Rental"
  ];

  String city_id;
  List<String> city = [
    "Delhi",
    "Mumbai",
    "Bangalore",
    "Chennai"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Title(color: Colors.white,
            child: Text("CRUX",
                style: GoogleFonts.poppins(
                  fontSize: 40,
                )
            )
        ),
      ),
      endDrawer: new Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                      Colors.amber,
                      Colors.amberAccent
                    ]
                ),
              ),
              child: new UserAccountsDrawerHeader(
                accountName: new Text(Constants.myName),
                accountEmail: new Text(Constants.myEmail),
              ),),
            new ListTile(
              leading: Icon(Icons.person),
              title: new Text('User Profile',
                  style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        userProfile()));
              },
            ),
            new Divider(
              color: Colors.amber,
            ),
            new ListTile(
              leading: Icon(Icons.settings),
              title: new Text('Settings',
                  style: GoogleFonts.poppins()),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Settings()));
              },
            ),
            new Divider(
              color: Colors.amber,
            ),
            new ListTile(
              leading: Icon(Icons.arrow_back),
              title: new Text('Log Out',
                  style: GoogleFonts.poppins()),
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => Authenticate()
                ));
              },
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropDownField(
                onValueChanged: (dynamic value) {
                  purpose_id = value;
                },
                value: purpose_id,
                required: true,
                labelText: "What's your purpose?",
                items: purpose,
              ),
              SizedBox.fromSize(size: Size(0, 10)),
              DropDownField(
                onValueChanged: (dynamic value) {
                  city_id = value;
                },
                value: city_id,
                required: true,
                labelText: "Where do you live?",
                items: city,
              ),
              SizedBox.fromSize(size: Size(0, 10)),
              GestureDetector(
                onTap: () {
                  if (purpose_id == 'Packers & Movers') {
                    Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          packersResults(city: city_id, purpose: purpose_id)),
                    );
                  }
                  else if (purpose_id == 'Bus Rental') {
                    Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          busResults(city: city_id, purpose: purpose_id)),
                    );
                  }
                  else if (purpose_id == 'Cab Rental') {
                    Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          cabResults(city: city_id,
                              purpose: purpose_id)),
                    );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 80,
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.amber,
                          Colors.amberAccent
                        ]
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('Go',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


