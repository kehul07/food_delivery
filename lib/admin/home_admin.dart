import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/admin/admin_food.dart';
import 'package:food_delivery/pages/detail.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';

import '../widgets/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {

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
  }
  bool icecream = true, pizza = false, salad = false, burger = false;


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
        return SingleChildScrollView(
          child: Column(
            children: List.generate(snapshot.data.docs.length, (index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Container(
                margin: EdgeInsets.only(right: 5, left: 5, bottom: 20),
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
                                  "Fresh and Healthy",
                                  style: AppWidget.LightTextFieldStyle(),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "\$" + ds["Price"],
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () async{
                                      await Database().deleteFoodFromAdmin(ds.reference);
                                      setState(() {

                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle
                                        ),
                                        child: Icon(Icons.delete_outline,color: Colors.white,)

                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Center(child: Text("Home Admin", style: AppWidget.HeadlineTextFieldStyle(),),),
            SizedBox(height: 50.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminFood()));
              },
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child:
                    Center(child: Text("Add Food Items", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),)) ,),
                ),
              ),
            SizedBox(height: 30,),

            showItemCategory(),

            SizedBox(height: 30,),

            Container(
                height: MediaQuery.of(context).size.height/1.8,
                child: allitemVertically()),

          ],
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
                  color: icecream ? Colors.black : Colors.white,
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
                  color: pizza ? Colors.black : Colors.white,
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
                  color: salad ? Colors.black : Colors.white,
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
                  color: burger ? Colors.black : Colors.white,
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
