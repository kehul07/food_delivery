import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/place_order.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widgets/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  String? id, wallet;
  int total=0, amount2=0;
  List<String> list = [];
  List<int> list2 = [];

  void startTimer(){
    Timer(Duration(seconds: 1), () {
      amount2=total;
      setState(() {

      });
    });
  }

  getthesharedpref()async{
    id= await SharedPref().getUserId();
    wallet= await SharedPref().getUserWallet();
    setState(() {

    });
  }

  Future<void> calculateTotal(AsyncSnapshot snapshot) async {
    int tempTotal = 0;
    for (var doc in snapshot.data.docs) {
      tempTotal += int.parse(doc["Total"]);
    }
    setState(() {
      total = tempTotal;
    });
  }


  ontheload()async{
    await getthesharedpref();
    foodStream= await Database().getFoodCart(id!);
    // calculateTotal();
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;

  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            calculateTotal(snapshot);
            list.clear();
            list2.clear();
            for (var doc in snapshot.data.docs) {
              list.add(doc["Name"]); // add name to list
              list2.add(int.parse(doc["Quantity"])); // add quantity to list2
            }

            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              height: 90,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text(ds["Quantity"])),
                            ),
                            SizedBox(width: 20.0),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  ds["Image"],
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                )
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$" + ds["Total"],
                                        style: AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await Database().deleteFoodFromCart(id!, ds.reference);
                                          setState(() {
                                            // Trigger re-calculation of total
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red
                                          ),
                                          child: Icon(Icons.delete_outline, color: Colors.white, size: 22),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          } else{
            return Center(child: Container(
                width: 30,
                height:30 ,
                child: CircularProgressIndicator()));
          }

        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2,
                child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Center(
                        child: Text(
                          "Food Cart",
                          style: AppWidget.redHeadlineTextFieldStyle(),
                        )))),
            SizedBox(
              height: 20.0,
            ),
            Container(
                height: MediaQuery.of(context).size.height/1.7,
                child: foodCart()),
            // Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    "\$"+ total.toString(),
                    style: AppWidget.semiBoldTextFieldStyle(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: ()async{
                if(int.parse(wallet!) > amount2){
                  int amount= int.parse(wallet!)-amount2;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PlaceOrder(amount: amount,id: id!,names: list,quantity: list2,total: amount2,)));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Insufficient Balance",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,));
                }

              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Center(
                    child: Text(
                      "CheckOut",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
