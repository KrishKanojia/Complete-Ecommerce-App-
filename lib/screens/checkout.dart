import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/cartmodel.dart';
import 'package:ecommerce_app/model/checkoutmodel.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/widget/cartsingleproduct.dart';
import 'package:ecommerce_app/widget/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

late ProductProvider productProvider;
late List<CheckOutModel> myList;

class _CheckOutState extends State<CheckOut> {
  Widget BottomDetail(String startname, String endname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startname,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(
          endname,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  late int index;
  User? user;
  double total = 0.0;
  Widget _buildBottom() {
    return Column(
        children: productProvider.UserModelList.map((e) {
      return Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              if (productProvider.getCheckOutModelList.isNotEmpty) {
                print("Product Order!!!");
                FirebaseFirestore.instance
                    .collection("Order")
                    .doc(user!.uid)
                    .set({
                  "Product": productProvider.checkOutModelList
                      .map((c) => {
                            "Product Name": c.name,
                            "Product Price": c.price,
                            "Product Quantity": c.quantity,
                            "Product Image": c.image,
                            "Product Color": c.color,
                            "Product Size": c.size,
                          })
                      .toList(),
                  "Total Price": total.toStringAsFixed(2),
                  "UserName": e.UserName,
                  "UserEmail": e.UserEmail,
                  "UserAddress": e.UserAddress,
                  "UserUid": user!.uid,
                });
                productProvider.clearCheckoutProduct();
                productProvider.clearCartProduct();
                productProvider.addNotification("Notification");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No Item Yet"),
                  ),
                );
              }
            },
            child: Text("BUY"),
          ));
    }).toList());
  }

  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;
    total;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quantity;
    });

    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;
    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Checkout Page"),
        centerTitle: true,
        actions: [
          NotificationButton(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 50,
        width: 150,
        child: _buildBottom(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: productProvider.getCheckOutListLength(),
                        itemBuilder: (context, myindex) {
                          index = myindex;
                          return CartSingleProduct(
                            isCount: true,
                            index: myindex,
                            image: productProvider
                                .getCheckOutModelList[myindex].image,
                            name: productProvider
                                .getCheckOutModelList[myindex].name,
                            price: productProvider
                                .getCheckOutModelList[myindex].price,
                            quantity: productProvider
                                .getCheckOutModelList[myindex].quantity,
                            color: productProvider
                                .getCheckOutModelList[myindex].color,
                            size: productProvider
                                .getCheckOutModelList[myindex].size,
                            check: false,
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BottomDetail(
                            "Your Price ", "\$ ${subTotal.toStringAsFixed(2)}"),
                        BottomDetail(
                            "Discount", "${discount.toStringAsFixed(2)}%"),
                        BottomDetail(
                            "Shipping", "\$ ${shipping.toStringAsFixed(2)}"),
                        BottomDetail("Total", "\$ ${total.toStringAsFixed(2)}"),
                      ],
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
