import 'package:ecommerce_app/screens/homepage.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ),
              );
            }),
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/aboutus1.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Text(
                      "Hello, I am Krish Kanojia and am a developer of this"
                      " Mobile Application using Flutter as well as regular contributor to this App.\n"
                      "This App aims to fulfill Customer requirements by using the modern business logic."
                      "This App has been developed with the google latest Technology Flutter.Please don't forget to give feedback.In (Contact Us) Option.\n"
                      "Thank You. Enjoy!!!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
