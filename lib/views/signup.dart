import 'package:com/helper/helperfunctions.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/database.dart';
import 'package:com/views/homepage.dart';
import 'package:com/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {

  final Function toggle;
  Signup(this.toggle);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  HelperFunctions helperFunctions = new HelperFunctions();

  final formkey = GlobalKey<FormState>();

  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController phoneNoTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp() {
    if(formkey.currentState.validate()){

      Map<String, String> userInfoMap = {
        'name' : usernameTextEditingController.text,
        'phoneNo' : phoneNoTextEditingController.text,
        'email' : emailTextEditingController.text,
      };

      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(usernameTextEditingController.text);
      HelperFunctions.saveUserPhonePreference(phoneNoTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      authMethods.signUpwithEmailAndPassword (
          emailTextEditingController.text,
          passwordTextEditingController.text
      ).then((val){
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomePage()));
      });
    }
  }

  String email, password, displayName, phoneNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: isLoading ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          )
      ):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80,left: 10),
                    child: Container(
                      height: 150.0,
                      width: 375.0,
                      child: Image.asset('images/logo1.png'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 355.0, 0.0, 0.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(165.0, 355.0, 0.0, 0.0),
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
            Container(
              height: MediaQuery.of(context).size.height,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Form(
                          key: formkey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty || val.length < 3 ? 'This field is required': null;
                                  },
                                controller: usernameTextEditingController,
                                style: simpleTextFieldStyle(),
                                decoration: textFieldInputDecoration('User Name'),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                  validator: (val){
                                    return val.length == 10 ? null: 'Enter a valid mobile number';
                                    },
                                  controller: phoneNoTextEditingController,
                                  style: simpleTextFieldStyle(),
                                  decoration: textFieldInputDecoration('Mobile Number')
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                validator: (val){
                                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val) ? null : "Please provide valid emailid";
                                  },
                                controller: emailTextEditingController,
                                style: simpleTextFieldStyle(),
                                decoration: textFieldInputDecoration('E-Mail'),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                  obscureText: true,
                                  validator: (val){
                                    return val.length > 6 ? null: 'Please provide password with 6+ characters';
                                    },
                                  controller: passwordTextEditingController,
                                  style: simpleTextFieldStyle(),
                                  decoration: textFieldInputDecoration('Password')
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: (){
                        signMeUp();
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
                        child: Text('Sign Up',
                          style: ButtonStyle(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have an account?',
                          style: ButtonStyle(),
                        ),
                        SizedBox(width: 5.0),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text('Sign In',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 18.0,
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
      )
    );
  }
}