import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/favouritemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  List<FavouriteModel> favouriteModelList = [];
  late FavouriteModel favouriteModel;

  // void getFavouriteData({
  //   required String name,
  //   required String image,
  //   required double price,
  //   required String size,
  //   required String color,
  // }) {
  //   favouriteModel = FavouriteModel(
  //     name: name,
  //     image: image,
  //     price: price,
  //     color: color,
  //     size: size,
  //   );
  //   favouriteModelList.add(favouriteModel);
  // }

  Future<void> getFavouriteData() async {
    List<FavouriteModel> newList = [];
    var db;
    try {
      db = await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("favourites")
          .get();
    } catch (e) {}

    if (db != null) {
      db.docs.forEach((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        favouriteModel = FavouriteModel(
            image: data["Image"],
            price: data["Price"],
            color: data["Color"],
            name: data["Name"],
            size: data["Size"],
            docId: data["DocId"],
            description: data["productDescription"]);
        newList.add(favouriteModel);
      });

      favouriteModelList = newList;
      print("Data fetched from Firebase");
      notifyListeners();
    } else {
      print("Value is Null");
    }
  }

  Future<void> deleteNews(String news) async {
    var docRef = await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favourites");

    if (docRef != null) {
      docRef.doc(news).delete();
    }
    notifyListeners();
  }

  List<FavouriteModel> get getFavouriteModelList {
    return List.from(favouriteModelList);
  }

  int getFavouriteModelListLength() {
    return favouriteModelList.length;
  }
}
