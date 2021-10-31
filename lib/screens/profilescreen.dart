import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/usermodel.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/cartscreen.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/widget/notification_button.dart';
import 'package:ecommerce_app/widget/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'login.dart';
import 'welcomescreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _pickedImage;
  var _image;
  late UserModel userModel;
  late TextEditingController userName;
  late TextEditingController phoneNumber;
  late TextEditingController address;
  bool isMale = false;
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  void finalValidation() async {
    await _uploadImage(image: _pickedImage);

    userDetailUpdate();
  }

  void vaildation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All Field Are Empty"),
        ),
      );
    } else if (userName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (userName.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else {
      if (_pickedImage != null) {
        finalValidation();
      }
      userDetailUpdate();
    }
  }

  String imageUrl = "";

  Future<void> userDetailUpdate() async {
    User? myUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("User").doc(myUser!.uid).update({
      "UserName": userName.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "PoheNumber": phoneNumber.text,
      "UserImage": imageUrl == "" ? "" : imageUrl,
      "UserAddress": address.text,
    });
  }

  Future<void> getImage({required ImageSource source}) async {
    _image = (await ImagePicker().pickImage(source: source))!;

    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  Future<void> _uploadImage({required File image}) async {
    User? user = FirebaseAuth.instance.currentUser;
    Reference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid");

    await storageReference.putFile(image);

    imageUrl = await storageReference.getDownloadURL();
    print(imageUrl + "Heloo Weorld");
  }

  Future<void> myDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Pick From Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick From Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildSingleContianer(String startName, String endName) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        width: 800,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                endName,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool edit = false;
  String userImage = "";
  Widget _buildContainerPart() {
    address = TextEditingController(text: userModel.UserAddress);
    userName = TextEditingController(text: userModel.UserName);
    phoneNumber = TextEditingController(text: userModel.UserPhoneNumber);

    if (userModel.UserGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
    return Column(
      children: [
        buildSingleContianer("Name", userModel.UserName),
        buildSingleContianer("Email", userModel.UserEmail),
        buildSingleContianer("Gender", userModel.UserGender),
        buildSingleContianer("Phone Number", userModel.UserPhoneNumber),
        buildSingleContianer("Adress", userModel.UserAddress),
      ],
    );
  }

  Widget _buildTextFormFieldPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(Name: "UserName", controller: userName),
          // buildSingleContianer("Email", userModel.UserEmail),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(userModel.UserEmail),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gender",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(isMale == true ? "Male" : "False"),
                ],
              ),
            ),
            // child: buildSingleContianer(
            //     "Gender", isMale == true ? "Male" : "False"),
          ),
          MyTextFormField(
            Name: "Phone Number",
            controller: phoneNumber,
          ),
          MyTextFormField(
            Name: "Address",
            controller: address,
          ),
        ],
      ),
    );
  }

  String userUid = "";
  void getUserUid() {
    User? myUser = FirebaseAuth.instance.currentUser;
    if (myUser != null) {
      userUid = myUser.uid;
    } else {
      userUid = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    productprovider = Provider.of<ProductProvider>(context, listen: false);

    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        title: Text("Profile Screen"),
        centerTitle: true,
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  });
                },
              ),
        actions: [
          edit == true
              ? IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      vaildation();
                    });
                  })
              : NotificationButton(),
        ],
      ),
      body: (FirebaseAuth.instance.currentUser != null)
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("User").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    // String id = document.id;
                    // data["id"] = id;
                    if (data["UserId"] == userUid) {
                      print("yes");
                      print(data["UserName"]);

                      userModel = UserModel(
                        UserName: data["UserName"],
                        UserAddress: data["UserAddress"],
                        UserEmail: data["Email"],
                        UserGender: data["UserGender"],
                        UserPhoneNumber: data["PhoneNumber"],
                        UserImage: data["UserImage"],
                      );
                      print("Getting image from source : ");
                      imageUrl = data["UserImage"];
                      //
                      return Container(
                        width: double.infinity,
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            //
                            //   child:
                            Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  width: double.infinity,
                                  height: 230,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: (_pickedImage == null)
                                              ? (userModel.UserImage == "")
                                                  ? Image.asset(
                                                      "assets/UserImage.png")
                                                  : Image.network(
                                                      userModel.UserImage,
                                                      fit: BoxFit.cover,
                                                      height: double.infinity,
                                                      width: double.infinity,
                                                    )
                                              : Image.file(
                                                  _pickedImage,
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                edit == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 220, top: 180),
                                        child: GestureDetector(
                                          onTap: () {
                                            myDialogBox();
                                          },
                                          child: CircleAvatar(
                                            maxRadius: 30,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            // ),
                            edit == true
                                ? _buildTextFormFieldPart()
                                : _buildContainerPart(),
                            // : Container(),
                            SizedBox(height: 20),
                            edit == false
                                ? ElevatedButton(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.purple,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        edit = true;
                                      });
                                    },
                                  )
                                : Container()
                          ],
                        ),
                      );
                    } else {
                      print("Id doesn't Match");
                      return Container();
                    }
                  }).toList(),
                );
              },
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
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
                  ),
                ],
              ),
            ),
    );
  }
}
