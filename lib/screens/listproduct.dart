import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/provider/category_provider.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:ecommerce_app/screens/search_category.dart';
import 'package:ecommerce_app/screens/search_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
  String name;
  bool isCategory = true;
  final List<Product> snapshot;
  ListProduct(
      {required this.name, required this.isCategory, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          isCategory == true
              ? IconButton(
                  onPressed: () {
                    categoryProvider.getSearchList(List: snapshot);
                    showSearch(context: context, delegate: SearchCategory());
                  },
                  icon: Icon(Icons.search),
                )
              : IconButton(
                  onPressed: () {
                    productProvider.getSearchList(List: snapshot);
                    showSearch(context: context, delegate: SearchProduct());
                  },
                  icon: Icon(Icons.search),
                ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      childAspectRatio: 0.95,
                      children: snapshot
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                        image: e.image,
                                        name: e.name,
                                        price: e.price),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(),
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                        child: Image(
                                          image: NetworkImage("${e.image}"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.085,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "${e.name}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "\$ ${e.price.toString()}",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  // GridView.builder(
                  //     scrollDirection: Axis.vertical,

                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 5,
                  //       mainAxisSpacing: 15,
                  //       childAspectRatio: 0.8,
                  //     ),
                  //     itemBuilder: (ctx, index) => Container(
                  //           margin: EdgeInsets.only(left: 15, right: 15),
                  //           width: 100,
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.black26,
                  //                 blurRadius: 2.0,
                  //                 spreadRadius: 0.0,
                  //                 offset: Offset(
                  //                     1.0, 1.0), // shadow direction: bottom right
                  //               )
                  //             ],
                  //           ),
                  //           child: Column(
                  //             children: [
                  //               Container(
                  //                 margin: EdgeInsets.only(bottom: 8),
                  //                 decoration: BoxDecoration(),
                  //                 width: 170,
                  //                 height: 170,
                  //                 child: ClipRRect(
                  //                   child: Image(
                  //                     image: NetworkImage(
                  //                         snapshot.data.document[index]["image"]),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Text(
                  //                 "\$ ${snapshot.data.document[index]["name"]}",
                  //                 style: TextStyle(
                  //                   fontSize: 20,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //               SizedBox(height: 5),
                  //               Text(
                  //                 "${snapshot.data.document[index]["price"]}",
                  //                 style: TextStyle(
                  //                   fontSize: 17,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
