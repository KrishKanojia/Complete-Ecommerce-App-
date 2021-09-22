import 'package:ecommerce_app/screens/checkout.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/widget/cartsingleproduct.dart';
import 'package:ecommerce_app/widget/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

late ProductProvider productProvider;
late int myIndex = 0;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Cart Page"),
        centerTitle: true,
        actions: [
          NotificationButton(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // primary: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              productProvider.addNotification("Notification");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckOut(),
                ),
              );
            },
            child: Text(
              "Continue",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: productProvider.getCartModelListLength(),
          itemBuilder: (context, index) => CartSingleProduct(
            isCount: false,
            index: index,
            image: productProvider.getCartModelList[index].image,
            name: productProvider.getCartModelList[index].name,
            price: productProvider.getCartModelList[index].price,
            quantity: productProvider.getCartModelList[index].quantity,
            color: productProvider.getCartModelList[index].color,
            size: productProvider.getCartModelList[index].size,
            check: true,
          ),
        ),
      ),
    );
  }
}
