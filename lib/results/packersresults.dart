import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/CompanyProfiles/packersprofile.dart';
import 'package:com/helper/authenticate.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:com/views/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com/views/settings.dart';
import 'package:com/views/userprofile.dart';

void main() {
  runApp(MaterialApp(
    home: packersResults(),
  ));
}

class packersResults extends StatefulWidget {
  packersResults({Key key, this.city, this.purpose}) : super(key: key);
  final String city, purpose;
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<packersResults> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
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
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[
                        Colors.amber,
                        Colors.amberAccent
                      ])
              ),
              child:new UserAccountsDrawerHeader(
                accountName: new Text('Swetan'),
                accountEmail: new Text('swetanreddys@gmail.com'),
              ),
            ),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('searches')
                        .where('Category', isEqualTo: widget.purpose)
                        .where('City', isEqualTo: widget.city).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ${snapshot.error}');
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, int index) {
                            DocumentSnapshot doc = snapshot.data.documents[index];
                            print('value ${doc.data}');
                            return Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) => PackersProfile(companyName:doc.data["CompanyName"],city: doc.data["City"],  purpose: 'price quotation')),
                                  );
                                },
                                child: ListTile(
                                  title: Text('${doc.data["CompanyName"]}'),
                                  subtitle: Text('Location: ${doc.data["Location"]}'),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Text('Loading...');
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}



