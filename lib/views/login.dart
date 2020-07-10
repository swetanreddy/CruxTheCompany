import 'package:com/views/companylogin.dart';
import 'package:com/views/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/helper/helperfunctions.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:com/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  final Function toggle;
  Login(this.toggle);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formkey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  signIn() {
    if(formkey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

      databaseMethods.getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions
            .saveUserNameSharedPreference(snapshotUserInfo.documents[0].data['name']);
      });
      setState(() {
        isLoading = true;
      });

      authMethods.signInWithEmailAndPassword(
          emailTextEditingController.text,
          passwordTextEditingController.text).then((val){
        if(val != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomePage()));
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      height: 250.0,
                      width: 400.0,
                      child: Image.asset('images/logo1.png'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 320.0, 0.0, 0.0),
                    child: Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 355.0, 0.0, 0.0),
                    child: Text(
                      'There',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(120.0, 355.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val) ? null : "Please provide valid emailid";
                            },
                            controller: emailTextEditingController,
                            style: simpleTextFieldStyle(),
                            decoration: textFieldInputDecoration('E-Mail'),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                              obscureText: true,
                              validator: (val){
                                return val.length > 6 ? null: 'Password is too short!';
                              },
                              controller: passwordTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration('Password')
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                        child: Text('Forgot Password?',
                          style: simpleTextFieldStyle(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
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
                        child: Text('Sign In',
                          style: ButtonStyle(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('New here?',
                          style: ButtonStyle(),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Register',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Own a Company?',
                          style: ButtonStyle(),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) => CompanyLogin()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Hop IN!!',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


