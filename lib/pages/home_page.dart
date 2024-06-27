import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/pages/detail.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widgets/widget_support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Stream? fooditemstream ;
  String? name;

  ontheload() async{
    fooditemstream = await  Database().getItem("Ice-cream");
    name = await SharedPref().getUserName();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red, // Change this to your desired color
        statusBarIconBrightness: Brightness.light, // For light icons on the status bar
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    );
  }
  bool icecream = true, pizza = false, salad = false, burger = false;


  Widget allitem()  {
    return StreamBuilder(stream: fooditemstream, builder: (context,AsyncSnapshot snapshot){
      return snapshot.hasData ? ListView.builder(
        padding: EdgeInsets.only(left: 10),
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Detail(name: ds["Name"],detail: ds["Detail"],image: ds["Image"],price: ds["Price"],)));
            },
            child: Container(
              margin: EdgeInsets.all(8),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            ds["Image"],
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          ds["Name"],
                          style: AppWidget.semiBoldTextFieldStyle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Fresh and Healthy",
                          style: AppWidget.LightTextFieldStyle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$"+ds["Price"],
                          style: AppWidget.semiBoldTextFieldStyle(),
                        )
                      ]),
                ),
              ),
            ),
          );
      }) : Center(child: Container(
        width: 30,
          height:30 ,
          child: CircularProgressIndicator()));
    });
  }


  // Widget allitemVertically()  {
  //   return StreamBuilder(stream: fooditemstream, builder: (context,AsyncSnapshot snapshot){
  //     return snapshot.hasData ? ListView.builder(
  //         padding: EdgeInsets.zero,
  //         itemCount: snapshot.data.docs.length,
  //         shrinkWrap: true,
  //         scrollDirection: Axis.vertical,
  //         itemBuilder: (context,index){
  //           DocumentSnapshot ds = snapshot.data.docs[index];
  //           return GestureDetector(
  //             onTap: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => Detail(name: ds["Name"],detail: ds["Detail"],image: ds["Image"],price: ds["Price"],)));
  //             },
  //             child: Container(
  //               margin: EdgeInsets.only(right: 20, left: 20,bottom: 20),
  //               child: Material(
  //                 borderRadius: BorderRadius.circular(20),
  //                 elevation: 5,
  //                 child: Container(
  //                   padding: EdgeInsets.all(10),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       ClipRRect(
  //                         borderRadius: BorderRadius.circular(30),
  //                         child: Image.network(
  //                           ds["Image"],
  //                           height: 120,
  //                           width: 120,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Column(
  //                         children: [
  //                           Container(
  //                             width: MediaQuery.of(context).size.width / 2,
  //                             child: Text(
  //                               ds["Name"],
  //                               style: AppWidget.semiBoldTextFieldStyle(),
  //                             ),
  //                           ),
  //                           Container(
  //                             width: MediaQuery.of(context).size.width / 2,
  //                             child: Text(
  //                               "Honey goot chees",
  //                               style: AppWidget.LightTextFieldStyle(),
  //                             ),
  //                           ),
  //                           Container(
  //                             width: MediaQuery.of(context).size.width / 2,
  //                             child: Text(
  //                               "\$"+ds["Price"],
  //                               style: AppWidget.semiBoldTextFieldStyle(),
  //                             ),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             )
  //           );
  //         }) : CircularProgressIndicator();
  //   });
  // }

  Widget allitemVertically() {
    return StreamBuilder(
      stream: fooditemstream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Container(
              width: 30,
              height:30 ,
              child: CircularProgressIndicator()));
        }
        return Column(
          children: List.generate(snapshot.data.docs.length, (index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      name: ds["Name"],
                      detail: ds["Detail"],
                      image: ds["Image"],
                      price: ds["Price"],
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            ds["Image"],
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Honey goot chees",
                                  style: AppWidget.LightTextFieldStyle(),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "\$" + ds["Price"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    name==null? Text(
                      "Hello ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ):
                    Text(
                      "Hello "+name!+",",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                  child: Text("Delicious Food",
                      style: AppWidget.HeadlineTextFieldStyle())),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text("Discover and Get Great Food",
                    style: AppWidget.LightTextFieldStyle()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  child: showItemCategory()),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 280,
                  child: allitem()),
              SizedBox(
                height: 30,
              ),
              allitemVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItemCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream = true;
            pizza = false;
            salad = false;
            burger = false;
            fooditemstream = await  Database().getItem("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: icecream ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/ice-cream.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: icecream ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = true;
            salad = false;
            burger = false;
            fooditemstream = await  Database().getItem("Pizza");

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: pizza ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/pizza.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = true;
            burger = false;
            fooditemstream = await  Database().getItem("Salad");

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: salad ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/salad.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: salad ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            icecream = false;
            pizza = false;
            salad = false;
            burger = true;
            fooditemstream = await  Database().getItem("Burger");

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: burger ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/burger.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
