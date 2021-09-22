import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/usermodel.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/homepage.dart';
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

  @override
  void initState() {
    super.initState();
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Homepage(),
                ),
              );
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                            MaterialPageRoute(builder: (ctx) => Homepage()));
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
