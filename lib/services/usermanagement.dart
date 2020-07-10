import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  storeNewUser(user, displayName, context) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'displayName': displayName,
      'isEmailVerified': user.isEmailVerified,
      'uid': user.uid
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}