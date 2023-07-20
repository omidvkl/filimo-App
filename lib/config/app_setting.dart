
import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {

  // setUserId(String id) async {
  //   var pref = await SharedPreferences.getInstance();
  //   pref.setString('userId', id);
  // }

  Future<String> getUserId () async {
    var pref = await SharedPreferences.getInstance();
    String id = pref.getString('userId') ??'';
    return id;
  }

  setUserLogged(bool loginStatus) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool('state', loginStatus);
  }

  Future<bool> isUserLogged() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool('state') ?? false;
  }

  saveUserProfile(String id,String name,String email) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('id', id);
    pref.setString('name', name);
    pref.setString('email', email);

  }
  Future<String> getName() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString('name') ?? '';
  }
  Future<String> getEmail() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString('email') ?? '';
  }



}