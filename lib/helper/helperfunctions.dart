import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = 'USERISLOGGEDIN';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';
  static String sharedPreferenceUserPhoneKey = 'USERPHONEKEY';
  static String sharedPreferenceAdminLoggedInKey = 'ADMINISLOGGEDIN';
  static String sharedPreferenceAdminCompanyNameKey = 'ADMINCOMPANYNAMEKEY';
  static String sharedPreferenceAdminEmailKey = 'ADMINEMAILKEY';
  static String sharedPreferenceAdminPhoneKey = 'ADMINPHONEKEY';

  //saving data to shared perference
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(
      // ignore: non_constant_identifier_names
      String UserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, UserName);
  }

  static Future<bool> saveUserEmailSharedPreference(
      String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool> saveUserPhonePreference(
      String phoneNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhoneKey, phoneNo);
  }

  static Future<bool> saveAdminLoggedInSharedPreference(
      bool isAdminLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceAdminLoggedInKey, isAdminLoggedIn);
  }

  static Future<bool> saveAdminCompanyNameSharedPreference(
      // ignore: non_constant_identifier_names
      String AdminCompanyName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceAdminCompanyNameKey, AdminCompanyName);
  }

  static Future<bool> saveAdminEmailSharedPreference(
      String AdminEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceAdminEmailKey, AdminEmail);
  }

  static Future<bool> saveAdminPhonePreference(
      String AdminphoneNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserPhoneKey, AdminphoneNo);
  }

  // getting data from shared perference
  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceAdminPhoneKey);
  }

  static Future<String> getUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getUserPhoneSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserPhoneKey);
  }

  static Future<bool> getAdminLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceAdminLoggedInKey);
  }

  static Future<String> getAdminCompanyNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceAdminCompanyNameKey);
  }

  static Future<String> getAdminEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceAdminEmailKey);
  }

  static Future<String> getAdminPhoneSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceAdminPhoneKey);
  }
}