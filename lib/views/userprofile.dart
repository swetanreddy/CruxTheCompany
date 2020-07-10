import 'package:com/helper/authenticate.dart';
import 'package:com/helper/constants.dart';
import 'package:com/helper/helperfunctions.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:com/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:com/views/settings.dart';
import 'package:com/views/homepage.dart';

class userProfile extends StatefulWidget {

  userProfile({Key key, this.email}) : super(key: key);
  String email;

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  String displayName, email, phoneNo;

  @override
  void initState() {
    getUserName();
    getUserEmail();
    getUserPhone();
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
    databaseMethods.getAdminByEmail(Constants.myEmail).then((val) {
      setState(() {
        val;
      });
    });
    setState(() { });
  }

  getUserPhone() async {
    Constants.myPhone = await HelperFunctions.getUserPhoneSharedPreference();
    databaseMethods.getAdminByPhone(Constants.myPhone).then((val) {
      setState(() {
        val;
      });
    });
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Title(
          color: Colors.white,
          child: Text("CRUX",
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Poppins'
            ),
          ),
        ),
      ),
      endDrawer: new Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.amber, Colors.amberAccent]
                ),
              ),
              child: null,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: new Text('Home Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => new HomePage()));
                },
            ),
            Divider(color: Colors.amber),
            ListTile(
              leading: Icon(Icons.settings),
              title: new Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => new Settings()));
                },
            ),
            Divider(color: Colors.amber),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: new Text('Log Out', style: GoogleFonts.poppins()),
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => Authenticate()));
                },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Hero(
                  tag: 'images/logo1.png',
                  child: Container(
                    height: 125.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(62.5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/logo1.png'))),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                Constants.myName,
                style: ButtonStyle(),
              ),
              SizedBox(height: 6.0),
              Text(
                Constants.myEmail,
                style: simpleTextFieldStyle(),
              ),
              SizedBox(height: 6.0),
              Text(
                Constants.myPhone,
                style: simpleTextFieldStyle(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
