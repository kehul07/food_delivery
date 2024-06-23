import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/pages/bottom_nav.dart';
import 'package:food_delivery/pages/login.dart';
import 'package:food_delivery/widgets/widget_support.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name="",email="",password="";
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  final  _formKey = GlobalKey<FormState>();

  Future<String> register(String e , String p) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: e, password: p).then((value) {
        print("Register Successfully");
      });
      return "Register Successfully";
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
    return  Scaffold(
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
                        height: MediaQuery.of(context).size.height/1.7,
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
                              Text("Sign up",style: AppWidget.HeadlineTextFieldStyle(),),
                              SizedBox(height: 30,),
                              TextFormField(
                                validator: (value)=>value==""? "Enter any Name" : null,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                  prefixIcon: Icon(Icons.person_outlined),
                                ),
                              ),
                              SizedBox(height: 30,),
                              TextFormField(
                                validator: (value)=>value!.isEmpty? "Email can't be empty.":null,
                                controller: emailController,
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

                              SizedBox(height: 60,),
                              GestureDetector(
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                    name = nameController.text.toString();
                                    email = emailController.text.toString();
                                    password = passController.text.toString();
                                      register(emailController.text,passController.text).then((value){
                                        if(value == "Register Successfully"){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Register Successfully",style: TextStyle(color: Colors.white,fontSize: 18),),backgroundColor: Colors.green,));
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNav()));
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(value,style: TextStyle(color: Colors.white,fontSize: 18),),backgroundColor: Colors.red,));
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
                                    child: Center(child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Poppins1',fontWeight: FontWeight.bold),)),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                      },
                        child: Text("Already have an account? Login",style: AppWidget.semiBoldTextFieldStyle(),))
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
