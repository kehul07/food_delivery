import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/pages/signup.dart';
import 'package:food_delivery/widgets/content_model.dart';
import 'package:food_delivery/widgets/widget_support.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentPage = 0;
  late PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.red, // Change this to your desired color
        statusBarIconBrightness: Brightness.light, // For light icons on the status bar
        statusBarBrightness: Brightness.dark, // For iOS
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        contents[i].image,
                        height: 400,
                        width: MediaQuery.of(context).size.width ,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        contents[i].title,
                        style: AppWidget.HeadlineTextFieldStyle(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        contents[i].description,
                        style: AppWidget.LightTextFieldStyle(),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                contents.length, (index) => buildDot(index, context)),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (currentPage == contents.length - 1) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            }
            _controller.nextPage(
                duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.all(40),
            child: Center(
                child: Text(currentPage==contents.length-1 ? "Start" : "Next",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
        )
      ]),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentPage == index ? 20 : 7,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.red),
    );
  }
}
