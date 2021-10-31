import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/categoryicon.dart';

import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<Product> pants = [];
  late Product pantData;
  List<Product> shirts = [];
  late Product shirtData;
  List<Product> dresses = [];
  late Product dressData;
  List<Product> shoes = [];
  late Product shoeData;
  List<Product> tie = [];
  late Product tieData;
  List<CategoryIcon> categoryIcon = [];
  late CategoryIcon categoryiconData;

  Future<void> getCategoryIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot categoryicon =
        await FirebaseFirestore.instance.collection("categoryicon").get();

    categoryicon.docs.forEach(
      (element) {
        categoryiconData = CategoryIcon(
          image: element.get("image"),
          name: element.get("name"),
        );
        newList.add(categoryiconData);
      },
    );
    categoryIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> getCategoryIconList() {
    return categoryIcon;
  }

  Future<void> getPantData() async {
    List<Product> newList = [];
    QuerySnapshot pantSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("5ozukHEKyOLEnSS3r93Q")
        .collection("pant")
        .get();

    pantSnapshot.docs.forEach(
      (element) {
        pantData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(pantData);
      },
    );
    pants = newList;
    notifyListeners();
  }

  List<Product> getPantList() {
    return pants;
  }

  Future<void> getShirtData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("5ozukHEKyOLEnSS3r93Q")
        .collection("shirt")
        .get();

    shirtSnapshot.docs.forEach(
      (element) {
        shirtData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(shirtData);
      },
    );
    shirts = newList;
    notifyListeners();
  }

  List<Product> getShirtList() {
    return shirts;
  }

  Future<void> getDressData() async {
    List<Product> newList = [];
    QuerySnapshot dressSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("5ozukHEKyOLEnSS3r93Q")
        .collection("dress")
        .get();

    dressSnapshot.docs.forEach(
      (element) {
        dressData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(dressData);
      },
    );
    dresses = newList;
    notifyListeners();
  }

  List<Product> getDressList() {
    return dresses;
  }

  Future<void> getShoeData() async {
    List<Product> newList = [];
    QuerySnapshot shoeSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("5ozukHEKyOLEnSS3r93Q")
        .collection("shoe")
        .get();

    shoeSnapshot.docs.forEach(
      (element) {
        shoeData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(shoeData);
      },
    );
    shoes = newList;
    notifyListeners();
  }

  List<Product> getShoeList() {
    return shoes;
  }

  Future<void> getTieData() async {
    List<Product> newList = [];
    QuerySnapshot tieSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("5ozukHEKyOLEnSS3r93Q")
        .collection("mobile")
        .get();

    tieSnapshot.docs.forEach(
      (element) {
        tieData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(tieData);
      },
    );
    tie = newList;
    notifyListeners();
  }

  List<Product> getTieList() {
    return tie;
  }

  List<Product> searchList = [];
  void getSearchList({required List<Product> List}) {
    searchList = List;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query) ||
          element.name.contains(query);
    }).toList();
    return searchShirt;
  }
}
