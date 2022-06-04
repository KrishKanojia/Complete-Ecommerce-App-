import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/signup.dart';
import 'package:ecommerce_app/widget/passwordtextformfield.dart';
import 'package:ecommerce_app/widget/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  bool obserText = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void validation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Both Field Are Empty"),
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
    } else {
      final FormState? _form = _formKey.currentState;
      if (_form!.validate()) {
        try {
          String _email = email.text.trim();
          String emailtolower = _email.toLowerCase();
          UserCredential User = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailtolower, password: password.text);
          print("User Logged In" + User.user!.uid);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        }
      } else {
        print("No");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Container(
                alignment: Alignment.center, // This is needed
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ),
              // Image.asset("assets/logo.png", width: 300, height: 200),
              Spacer(
                flex: 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyTextFormField(
                      Name: "Email",
                      controller: email,
                    ),
                    PasswordTextFormField(
                      name: "Password",
                      controller: password,
                      onTap: () {
                        setState(() {
                          obserText = !obserText;
                        });
                      },
                      obscureText: obserText,
                    ),
                    Container(
                      child: Column(
                        children: [
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
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "I have no Account! ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => Signup(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
