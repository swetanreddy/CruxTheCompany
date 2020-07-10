import 'package:com/helper/authenticate.dart';
import 'package:com/helper/constants.dart';
import 'package:com/helper/helperfunctions.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:com/widgets/widget.dart';
import 'package:flutter/material.dart';

class AdminProfile extends StatefulWidget {

  AdminProfile({Key key, this.email}) : super(key: key);
  String email;

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  String CompanyName, email, phoneNo;

  @override
  void initState() {
//    getAdminCompanyName();
    getAdminEmail();
    getAdminPhone();
    super.initState();
  }

//  getAdminCompanyName() async {
//    Constants.myName = await HelperFunctions.getAdminCompanyNameSharedPreference();
//    databaseMethods.getUserByUsername(Constants.myName).then((val) {
//      setState(() {
//        val;
//      });
//    });
//    setState(() { });
//  }

  getAdminEmail() async {
    Constants.myEmail = await HelperFunctions.getAdminEmailSharedPreference();
    databaseMethods.getUserByUserEmail(Constants.myEmail).then((val) {
      setState(() {
        val;
      });
    });
    setState(() { });
  }

  getAdminPhone() async {
    Constants.myPhone = await HelperFunctions.getUserPhoneSharedPreference();
    databaseMethods.getUserByUserPhone(Constants.myPhone).then((val) {
      setState(() {
        val;
      });
    });
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'ABC',
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
              SizedBox(height: 40.0),
              GestureDetector(
                onTap: () {
                  authMethods.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => Authenticate()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 250.0,
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
                  child: Text('Logout',
                    style: ButtonStyle(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
