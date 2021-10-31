import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/usermodel.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/welcomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contactus extends StatefulWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  final TextEditingController message = TextEditingController();
  String name = "", email = "";

  void _validation() async {
    if (message.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please Fill Message",
          ),
        ),
      );
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user!.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Message Submitted Thank You",
          ),
        ),
      );
    }
  }

  Widget _buildSingleField({required String name}) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext ctx) {
    Widget continueButton = TextButton(
      child: Text("SignUp"),
      onPressed: () {
        Navigator.of(ctx).pop();
      },
    );
    Widget signin = TextButton(
      child: Text("Signin"),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Login or SignUp First"),
      actions: [
        continueButton,
        signin,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    List<UserModel> user = productProvider.UserModelList;
    user.map((e) {
      name = e.UserName;
      email = e.UserEmail;
      print(e.UserName);
      return Container();
    }).toList();
    if (name == "") {
      print("No Text");
    }

    print(name);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Contact Us",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => Homepage(),
              ),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    print("User is not Logged in");
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/undraw_Login_re_4vu2.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: Colors.indigo,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  }
                }
                return Container(
                  // color: Colors.green,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sent Us Your Message",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      _buildSingleField(name: name),
                      _buildSingleField(name: email),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 200,
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          controller: message,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Message",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              _validation();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => Homepage()));
                            }),
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
