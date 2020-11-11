import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helperfunctions {
  static String userLoggedInKey = "USERLOGGEDINKEY";

  static saveUserLoggedInDetails({@required bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInKey, isLoggedin);
  }

  static Future<bool> getUserLoggedInDetails({bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(userLoggedInKey, isLoggedin);
  }
}
