import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUsername(String username) async {
    return await Firestore.instance.collection('users')
        .where('name', isEqualTo : username)
        .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection('users')
        .where('email', isEqualTo : userEmail)
        .getDocuments();
  }

  getUserByUserPhone(String phoneNo) async {
    return await Firestore.instance.collection('users')
        .where('phoneNo', isEqualTo : phoneNo)
        .getDocuments();
  }

  getAdminByCompanyID(String CompanyID) async {
    return await Firestore.instance.collection('admins')
        .where('CompanyID', isEqualTo : CompanyID)
        .getDocuments();
  }

  getAdminByEmail(String AEmail) async {
    return await Firestore.instance.collection('admins')
        .where('Email', isEqualTo : AEmail)
        .getDocuments();
  }

  getAdminByPhone(String APhoneNo) async {
    return await Firestore.instance.collection('admins')
        .where('PhNo', isEqualTo : APhoneNo)
        .getDocuments();
  }

  uploadUserInfo(userMap){
    Firestore.instance.collection('users')
        .add(userMap).catchError((e) {
      print(e.toString());
    });
  }

}