import 'package:ecommerce_app/provider/favourite_provider.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:ecommerce_app/widget/favouritesingleproduct.dart';
import 'package:ecommerce_app/widget/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late FavouriteProvider favouriteProvider;

  @override
  Widget build(BuildContext context) {
    favouriteProvider = Provider.of<FavouriteProvider>(
      context,
    );
    favouriteProvider.getFavouriteData();
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
        title: Text("Favourite Page"),
        centerTitle: true,
        actions: [
          NotificationButton(),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User? user = FirebaseAuth.instance.currentUser;

                if (user == null) {
                  print("User is not Logged in");
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  );
                }
              }
              return ListView.builder(
                  itemCount: favouriteProvider.getFavouriteModelListLength(),
                  itemBuilder: (context, index) {
                    return FavouriteSingleProduct(
                      name: favouriteProvider.favouriteModelList[index].name,
                      image: favouriteProvider.favouriteModelList[index].image,
                      price: favouriteProvider.favouriteModelList[index].price,
                      size: favouriteProvider.favouriteModelList[index].size,
                      color: favouriteProvider.favouriteModelList[index].color,
                      check: true,
                      index: index,
                      description: favouriteProvider
                          .favouriteModelList[index].description,
                      docId: favouriteProvider.favouriteModelList[index].docId,
                    );
                  });
            }),
      ),
    );
  }
}
