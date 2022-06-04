import 'package:ecommerce_app/provider/favourite_provider.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final String color;
  final String size;
  final String description;
  late String docId;
  final double price;
  int index;
  bool check;
  FavouriteSingleProduct({
    required this.index,
    required this.image,
    required this.color,
    required this.size,
    required this.name,
    required this.price,
    required this.check,
    required this.description,
    this.docId = "",
  });

  @override
  _FavouriteSingleProductState createState() => _FavouriteSingleProductState();
}

late FavouriteProvider favouriteProvider;

class _FavouriteSingleProductState extends State<FavouriteSingleProduct> {
  deletefavourite() {
    if (widget.docId != "") {
      print("Doc Id ${widget.docId}");
      setState(() {
        favouriteProvider.deleteNews(widget.docId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    favouriteProvider = Provider.of<FavouriteProvider>(context, listen: false);
    favouriteProvider.getFavouriteData();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => DetailScreen(
              image: widget.image,
              name: widget.name,
              price: widget.price,
              isColor: true,
              docId: widget.docId,
              description: widget.description,
            ),
          ),
        );
      },
      child: Card(
        // color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 130,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.63,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        // color: Colors.pink,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(fontSize: 20),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                                onPressed: () {
                                  deletefavourite();
                                  // productProvider.deleteCartProduct(widget.index);

                                  // productProvider
                                  //     .deleteCheckoutProduct(widget.index);
                                })
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.color,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              widget.size,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text("\$ ${widget.price}",
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
