import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery/services/database.dart';
import 'package:food_delivery/services/shared_pref.dart';
import 'package:food_delivery/widgets/widget_support.dart';
import 'package:http/http.dart' as http;

import '../widgets/app_constant.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  String? wallet, id;
  int? add;
  TextEditingController amountcontroller = new TextEditingController();

  getthesharedpref() async {
    wallet = await SharedPref().getUserWallet();
    id = await SharedPref().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }



  Map<String,dynamic>? paymentIntent;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    ontheload();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red, // Change this to your desired color
        statusBarIconBrightness:
            Brightness.light, // For light icons on the status bar
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet==null ? CircularProgressIndicator(): Container(
        margin: EdgeInsets.only(top: 20),
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
                      "Wallet",
                      style: AppWidget.redHeadlineTextFieldStyle(),
                    )))),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFf2f2f2),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/wallet.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Wallet",
                        style: AppWidget.LightTextFieldStyle(),
                      ),
                      Text(
                        "\$" + "$wallet",
                        style: AppWidget.boldTextFieldStyle(),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Add Money",
                style: AppWidget.boldTextFieldStyle(),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    makePayment("100");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$"+"100",style: AppWidget.boldTextFieldStyle(),),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    makePayment("500");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$"+"500",style: AppWidget.boldTextFieldStyle(),),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    makePayment("1000");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$"+"1000",style: AppWidget.boldTextFieldStyle(),),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    makePayment("2000");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFe9e2e2)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("\$"+"2000",style: AppWidget.boldTextFieldStyle(),),
                  ),
                ),

              ],
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                openEdit();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // color: Color(0xFF008080),
                  // color: Colors.red.shade900,
                  color: Colors.red,
                  border: Border.all(color: Colors.red,width: 2),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Add Money",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "Poppins"),)),
              ),
            )
          ],
        ),
      ),
    );
  }
  //
  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        add = int.parse(wallet!) + int.parse(amount);

        await SharedPref().saveUserWallet(add.toString());
        await Database().UpdateUserWallet(id!, add.toString());
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        await getthesharedpref();

        // ignore: use_build_context_synchronously

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }


    createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }
  //
  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;

    return calculatedAmout.toString();
  }
  //
  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.cancel)),
                    SizedBox(
                      width: 60.0,
                    ),
                    Center(
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                          color: Color(0xFF008080),
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Amount"),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: amountcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter Amount'),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      makePayment(amountcontroller.text);
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFF008080),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}
