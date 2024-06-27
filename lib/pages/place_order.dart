import 'package:flutter/material.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widgets/widget_support.dart';

class PlaceOrder extends StatefulWidget {
  int amount ;
  int total;
  String id;
  List<String> names;
  List<int> quantity;
  PlaceOrder({required this.amount,required this.id,required this.names,required this.quantity,required this.total});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  var _formKey = GlobalKey<FormState>();



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
          "Place Order",
          style: AppWidget.redHeadlineTextFieldStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Name",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    validator: (value) => value=="" ? "Please Enter Name" : null,
                    controller: nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Name",
                        hintStyle: AppWidget.LightTextFieldStyle()),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Phone",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    validator: (value) => value=="" ? "Please Enter Phone" : null,
                    controller:phoneController ,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Phone",
                        hintStyle: AppWidget.LightTextFieldStyle()),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Address",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    validator: (value) => value=="" ? "Please Enter Address" : null,
                    maxLines: 6,
                    controller:addressController ,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Address",
                        hintStyle: AppWidget.LightTextFieldStyle()),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async{
                    if(_formKey.currentState!.validate()){
                      Map<String,dynamic> map = {
                        "Name":nameController.text,
                        "Address":addressController.text,
                        "Phone":phoneController.text,
                        "Amount" : widget.total,
                        "Status" : "Pending",
                        "Names" : widget.names,
                        "Quantities" : widget.quantity
                      };
                      await Database().addOrderInfo(map, widget.id!);
                      await Database().UpdateUserWallet(widget.id!, widget.amount.toString());
                      await SharedPref().saveUserWallet(widget.amount.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Placed Successfully!!",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),backgroundColor: Colors.green,));
                    }

                  },
                  child: Center(
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Place Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
