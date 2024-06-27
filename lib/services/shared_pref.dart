import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static String userIdKey = "USERIDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userWalletKey = "USERWALLETKEY";
  static String userProfileKey = "USERPROFILEKEY";


  Future<bool> saveUserId(String id) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userIdKey, id);
  }
  Future<bool> saveUserName(String name) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userNameKey, name);
  }
  Future<bool> saveUserEmail(String email) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey,email);
  }
  Future<bool> saveUserWallet(String wallet) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userWalletKey, wallet);
  }

  Future<bool> saveUserProfile(String userProfile) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userProfileKey, userProfile);
  }

  Future<String?> getUserId() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userIdKey);
  }
  Future<String?> getUserName() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
  Future<String?> getUserEmail() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
  Future<String?> getUserWallet() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userWalletKey);
  }

  Future<String?> getUserProfile() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userProfileKey);
  }




}