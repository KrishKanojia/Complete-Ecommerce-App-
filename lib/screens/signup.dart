import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/widget/passwordtextformfield.dart';
import 'package:ecommerce_app/widget/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  bool obserText = true;

  bool isMale = true;

  void validation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All Field Are Empty"),
        ),
      );
    } else if (userName.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 letter "),
        ),
      );
    } else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else if (address.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Address Is Empty"),
        ),
      );
    } else {
      try {
        UserCredential User = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        FirebaseFirestore.instance.collection("User").doc(User.user!.uid).set({
          "UserName": userName.text,
          "UserId": User.user!.uid,
          "Email": email.text,
          "UserGender": isMale == true ? "Male" : "Female",
          "PhoneNumber": phoneNumber.text,
          "UserAddress": address.text,
          "UserImage": "",
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => login(),
          ),
        );
      } on PlatformException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 1),
                Container(
                  alignment: Alignment.center, // This is needed
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                    width: 300,
                  ),
                ),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                MyTextFormField(
                  Name: "UserName",
                  controller: userName,
                ),
                SizedBox(height: size.height * 0.01),
                MyTextFormField(
                  Name: "Email",
                  controller: email,
                ),
                SizedBox(height: size.height * 0.01),
                PasswordTextFormField(
                  name: "Password",
                  controller: password,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      obserText = !obserText;
                    });
                  },
                  obscureText: obserText,
                ),
                SizedBox(height: size.height * 0.01),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = !isMale;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                    )),
                    child: Row(
                      children: [
                        Text(
                          isMale == true ? "Male" : "Female",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                MyTextFormField(
                  Name: "Phone Number",
                  controller: phoneNumber,
                ),
                SizedBox(height: size.height * 0.01),
                MyTextFormField(
                  Name: "Address",
                  controller: address,
                ),
                SizedBox(height: size.height * 0.01),
                ElevatedButton(
                  onPressed: () {
                    validation();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I have Already an Account! ",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
