import 'package:flutter/material.dart';

import 'detailscreen.dart';

class SingleProduct extends StatelessWidget {
  String image;
  String name;
  double price;
  String description;
  SingleProduct(
      {this.description = "",
      required this.name,
      required this.image,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          print("Its Working");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                name: name,
                image: image,
                price: price,
                isColor: false,
                description: description,
              ),
            ),
          );
        },
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: NetworkImage(
                      "$image",
                    ),
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 200,
                  )),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                height: 40,
                width: 100,
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: Color(0xffc7210e),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      )),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\$ $price",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
