import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod{
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }

  Future isLoggedin() async{
    var user = await FirebaseAuth.instance.currentUser;
    return user!=null;
  }

  Future SignOut() async{
    await FirebaseAuth.instance.signOut();
  }

  Future deleteUser() async{
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}