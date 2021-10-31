import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/provider/favourite_provider.dart';
import 'package:ecommerce_app/screens/cartscreen.dart';
import 'package:ecommerce_app/screens/signup.dart';
import 'package:ecommerce_app/widget/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import 'homepage.dart';
import 'login.dart';

class DetailScreen extends StatefulWidget {
  late final name;
  late double price;
  late final image;
  late bool isColor = false;
  late String docId;

  DetailScreen({
    required this.image,
    required this.name,
    required this.price,
    required this.isColor,
    this.docId = "",
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

late ProductProvider productProvider;
late FavouriteProvider favouriteProvider;

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;

  List<bool> sized = [true, false, false, false];
  Widget sizeProduct({String name = ""}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      width: 40,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  List<bool> colored = [true, false, false, false];
  Widget colorProduct({Color color = Colors.red}) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }

  int sizeIndex = 0;
  String size = "";
  void getsize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "S";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "M";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "L";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "XL";
      });
    }
  }

  int colorIndex = 0;
  String color = "";
  void getColor() {
    if (colorIndex == 0) {
      setState(() {
        color = "Green";
      });
    } else if (colorIndex == 1) {
      setState(() {
        color = "Yellow";
      });
    } else if (colorIndex == 2) {
      setState(() {
        color = "Blue";
      });
    } else if (colorIndex == 3) {
      setState(() {
        color = "Cyan";
      });
    }
  }

  deletefavourite() {
    // if (widget.docId != "") {
    print("Doc Id ${widget.docId}");
    if (widget.docId != "") {
      setState(() {
        favouriteProvider.deleteNews(widget.docId);
        Navigator.of(context).pop();
      });
    }
  }

  showAlertDialog(BuildContext ctx) {
    Widget continueButton = TextButton(
      child: Text("SignUp"),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Signup(),
          ),
        );
      },
    );
    Widget signin = TextButton(
      child: Text("Signin"),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => login(),
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

  User? user;

  checkUser({
    required String name,
    required double price,
    required String image,
    required String color,
    required String size,
  }) async {
    if (user != null) {
      setState(() {
        // print("Single News ${widget.index.toString()}");

        // widget.isColor = true;
      });

      var randomDoc = await FirebaseFirestore.instance
          .collection("User")
          .doc(user!.uid)
          .collection("favourites")
          .doc();

      FirebaseFirestore.instance
          .collection("User")
          .doc(user!.uid)
          .collection("favourites")
          .doc(randomDoc.id)
          .set({
        "Image": image,
        "Name": name,
        "Price": price,
        "Size": size,
        "Color": color,
        "DocId": randomDoc.id,
      });
      print("Data Uploaded");
      favouriteProvider.getFavouriteData();
    } else {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    favouriteProvider = Provider.of<FavouriteProvider>(context);

    favouriteProvider.getFavouriteData();
    try {
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      print("No User Logged In");
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Screen"),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          widget.isColor == false
              ? IconButton(
                  icon: Icon(
                    Icons.favorite_outline_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (user != null) {
                      setState(() {
                        getColor();
                        getsize();
                        widget.isColor = true;
                        checkUser(
                            name: widget.name,
                            price: widget.price,
                            image: widget.image,
                            color: color,
                            size: size);
                        print("Added To favourites");
                      });
                    } else {
                      showAlertDialog(context);
                    }
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isColor = false;
                      deletefavourite();
                    });
                  },
                ),
          NotificationButton(),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    child: Image(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.name}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$ ${widget.price}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Text(
                        "It is a long established fact on of letters,tent here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncccident, sometimes on purpose (injected humour and the like",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Size",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 300,
                          //
                          child: ToggleButtons(
                              children: [
                                sizeProduct(name: "S"),
                                sizeProduct(name: "M"),
                                sizeProduct(name: "L"),
                                sizeProduct(name: "XL"),
                              ],
                              onPressed: (int index) {
                                for (int indexBtn = 0;
                                    indexBtn < sized.length;
                                    indexBtn++) {
                                  if (indexBtn == index) {
                                    sized[indexBtn] = true;
                                  } else {
                                    sized[indexBtn] = false;
                                  }
                                }
                                setState(() {
                                  sizeIndex = index;
                                });
                              },
                              isSelected: sized),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Color",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 270,
                          child: ToggleButtons(
                            children: [
                              colorProduct(color: Colors.green),
                              colorProduct(color: Colors.yellow),
                              colorProduct(color: Colors.blue),
                              colorProduct(color: Colors.cyan),
                            ],
                            onPressed: (int index) {
                              setState(() {
                                for (int indexBtn = 0;
                                    indexBtn < colored.length;
                                    indexBtn++) {
                                  if (indexBtn == index) {
                                    colored[indexBtn] = true;
                                  } else {
                                    colored[indexBtn] = false;
                                  }
                                }
                              });
                              setState(() {
                                colorIndex = index;
                              });
                            },
                            isSelected: colored,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Quantity",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[400],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.remove),
                              onTap: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                            ),
                            Text(
                              "$count",
                              style: TextStyle(fontSize: 20),
                            ),
                            GestureDetector(
                              child: Icon(Icons.add),
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (user != null) {
                            getsize();

                            getColor();
                            productProvider.getcheckOutModelData(
                              name: widget.name,
                              image: widget.image,
                              color: color,
                              size: size,
                              quantity: count,
                              price: widget.price,
                              // index: myIndex,
                            );
                            productProvider.getCartData(
                              name: widget.name,
                              image: widget.image,
                              color: color,
                              size: size,
                              quantity: count,
                              price: widget.price,
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => CartScreen(),
                              ),
                            );
                          } else {
                            showAlertDialog(context);
                          }
                        },
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
