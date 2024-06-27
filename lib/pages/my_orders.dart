import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';

import '../widgets/widget_support.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  String? id, wallet;
  Stream? foodStream;
  getthesharedpref()async{
    id= await SharedPref().getUserId();
    wallet= await SharedPref().getUserWallet();
    setState(() {

    });
  }

  ontheload()async{
    await getthesharedpref();
    foodStream= await Database().getOrderIfo(id!);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ontheload();
    super.initState();
  }


  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Food Name",style: AppWidget.semiBoldTextFieldStyle(),),
                                Text("Quantity",style: AppWidget.semiBoldTextFieldStyle(),),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Column(
                              children: List.generate(ds["Names"].length, (index){
                                return(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(ds["Names"][index],style: AppWidget.semiLightTextFieldStyle(),),
                                      SizedBox(width: 5,),
                                      Text(ds["Quantities"][index].toString(),style: AppWidget.semiLightTextFieldStyle(),)
                                    ],
                                  )
                                );
                              }),
                            ),
                            SizedBox(width: 5.0),
                            Divider(),
                            SizedBox(width: 5.0),
                            Row(
                              children: [
                                Spacer(),
                                Text("Total Price : \$"+ds["Amount"].toString(),style: AppWidget.semiBoldTextFieldStyle(),),
                                SizedBox(width: 5,),
                              ],
                            ),
                            SizedBox(width: 15.0),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Delivery in 30 Min",style: AppWidget.semiLightTextFieldStyle(),),
                                    SizedBox(width: 5,),
                                    Icon(Icons.alarm),
                                  ],
                                ),
                                Spacer(),
                                Text("Status : "+ds["Status"],style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),)
                              ],
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "My Orders",
          style: AppWidget.redHeadlineTextFieldStyle(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
          child: foodCart(),
      ),
    );
  }
}



