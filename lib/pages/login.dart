import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/pages/bottom_nav.dart';
import 'package:food_delivery/pages/forgot_password.dart';
import 'package:food_delivery/pages/signup.dart';
import 'package:food_delivery/widgets/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email="",password="";
  var emailController = TextEditingController();
  var passController = TextEditingController();

  final  _formKey = GlobalKey<FormState>();


  Future<String> login(String e , String p) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: e, password: p).then((value) {
        print("Login Successful");
      });
      return "Login Successful";
    } on FirebaseAuthException catch (ex) {
      return ex.message.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red, // Change this to your desired color
        statusBarIconBrightness: Brightness.light, // For light icons on the status bar
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFff5c30),
                    Color(0xFFe74b1a)
                  ]
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/3 ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50,left: 20,right: 20),
                child: Column(
                  children: [
                    Center(child: Image.asset('images/logo.png',width: MediaQuery.of(context).size.width/1.5,)),
                    SizedBox(height: 50,),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        height: MediaQuery.of(context).size.height/1.9,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Text("Login",style: AppWidget.HeadlineTextFieldStyle(),),
                              SizedBox(height: 30,),
                              TextFormField(
                                controller: emailController,
                                validator: (value)=>value!.isEmpty? "Email can't be empty.":null,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                              SizedBox(height: 30,),
                              TextFormField(
                                controller: passController,
                                validator: (value)=>value!.length<8? "Password should have at least 8 characters.":null,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.password_outlined),
                                ),
                              ),
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text("Forgot Password?",style: AppWidget.semiBoldTextFieldStyle(),),
                                ),
                              ),
                              SizedBox(height: 60,),
                              GestureDetector(
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                        email = emailController.text.toString();
                                        password = passController.text.toString();
                                        login(emailController.text, passController.text).then((value){
                                          if(value=="Login Successful"){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Login Succesfully",style: TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.green,));
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(value,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,),);
                                          }
                                        });
                                  }
                                },
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 200,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFe74b1a),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Poppins1',fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));

                      },
                        child: Text("Don't have an account? Sign up",style: AppWidget.semiBoldTextFieldStyle(),))
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
