import 'package:com/helper/authenticate.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:com/views/homepage.dart';
import 'package:com/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:com/views/userprofile.dart';


class BusProfile extends StatefulWidget {

  // ignore: non_constant_identifier_names
  BusProfile({Key key, this.city, this.purpose, this.companyName, this.location, this.Services}) : super(key: key);
  // ignore: non_constant_identifier_names
  final String city, purpose, companyName, location, Services;
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<BusProfile> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('fetched values ${widget.city} ${widget.purpose}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Title(color: Colors.white,
            child: Text("CRUX",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Poppins')
            )
        ),
      ),
      endDrawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new ListTile(
              leading: Icon(Icons.person),
              title: new Text('User Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new userProfile()));
              },
            ),
            new Divider(
              color: Colors.amber,
            ),
            new ListTile(
              leading: Icon(Icons.home),
              title: new Text('Home Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new HomePage()));
              },
            ),
            new Divider(
              color: Colors.amber,
            ),
            new ListTile(
              leading: Icon(Icons.settings),
              title: new Text('Settings'),
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
              title: new Text('Log Out'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('${widget.companyName}',
              style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.black
              ),
            ),
            SizedBox(height: 20),
            Text('Services:',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87
              ),
            ),
            Text('${widget.Services}',
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54
              ),
            ),
            SizedBox(height: 100.0),
            Container(
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.grey,
                color: Colors.amberAccent,
                elevation: 7.0,
                child: GestureDetector(
                  child: Center(
                      child: Text('Book a BUS')
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
