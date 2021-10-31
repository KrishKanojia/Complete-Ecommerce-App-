import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/cartmodel.dart';
import 'package:ecommerce_app/model/checkoutmodel.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> features = [];
  late Product featureData;

  List<CartModel> cartModelList = [];
  late CartModel cartModel;

  List<UserModel> UserModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot UserSnapshot =
          await FirebaseFirestore.instance.collection("User").get();

      UserSnapshot.docs.forEach(
        (element) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;
          var local = currentUser.uid;
          if (local == data["UserId"]) {
            userModel = UserModel(
                UserAddress: data["UserAddress"],
                UserName: data["UserName"],
                UserEmail: data["Email"],
                UserGender: data["UserGender"],
                UserPhoneNumber: data["PhoneNumber"],
                UserImage: data["UserImage"]);
            newList.add(userModel);
          }
          UserModelList = newList;
        },
      );
    }
  }

  List<UserModel> get getUserModelList {
    return UserModelList;
  }

  void getCartData({
    required String name,
    required String color,
    required String size,
    required String image,
    required int quantity,
    required double price,
  }) {
    cartModel = CartModel(
      name: name,
      size: size,
      color: color,
      image: image,
      quantity: quantity,
      price: price,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
  }

  int getCartModelListLength() {
    return cartModelList.length;
  }

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  List<CheckOutModel> checkOutModelList = [];
  late CheckOutModel checkOutModel;

  void getcheckOutModelData({
    required String name,
    required String image,
    required String color,
    required String size,
    required int quantity,
    required double price,
  }) {
    checkOutModel = CheckOutModel(
      name: name,
      image: image,
      color: color,
      size: size,
      quantity: quantity,
      price: price,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CheckOutModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int getCheckOutListLength() {
    print("The Length of CheckOutList +  ${checkOutModelList.length}");
    return checkOutModelList.length;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void clearCartProduct() {
    cartModelList.clear();
    notifyListeners();
  }

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapshot = await FirebaseFirestore.instance
        .collection("product")
        .doc("1UxSlsxnQjdlQc3q12H6")
        .collection("featureproduct")
        .get();

    featureSnapshot.docs.forEach(
      (element) {
        featureData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(featureData);
      },
    );
    features = newList;
    notifyListeners();
  }

  List<Product> getFeatureList() {
    return features;
  }

  List<Product> homeFeatures = [];
  late Product homeFeatureData;

  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot homefeatureSnapshot =
        await FirebaseFirestore.instance.collection("homefeature").get();

    homefeatureSnapshot.docs.forEach(
      (element) {
        homeFeatureData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(homeFeatureData);
      },
    );
    homeFeatures = newList;
    notifyListeners();
  }

  List<Product> getHomeFeatureList() {
    return homeFeatures;
  }

  List<Product> newarchives = [];
  late Product newarchiveData;

  Future<void> getNewarchivesData() async {
    List<Product> newList = [];
    QuerySnapshot newarchiveSnapshot = await FirebaseFirestore.instance
        .collection("product")
        .doc("1UxSlsxnQjdlQc3q12H6")
        .collection("newarchives")
        .get();

    newarchiveSnapshot.docs.forEach(
      (element) {
        newarchiveData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(newarchiveData);
      },
    );
    newarchives = newList;
    notifyListeners();
  }

  List<Product> getNewarchivesList() {
    return newarchives;
  }

  List<Product> homeNewarchives = [];
  late Product homeNewarchiveData;

  Future<void> getHomeNewarchivesData() async {
    List<Product> newList = [];
    QuerySnapshot homeNewarchiveSnapshot =
        await FirebaseFirestore.instance.collection("homearchive").get();

    homeNewarchiveSnapshot.docs.forEach(
      (element) {
        homeNewarchiveData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(homeNewarchiveData);
      },
    );
    homeNewarchives = newList;
    notifyListeners();
  }

  List<Product> getHomeNewarchivesList() {
    return homeNewarchives;
  }

  List<String> NotificationList = [];

  void addNotification(String newNotification) {
    NotificationList.add(newNotification);
  }

  int get getNotificationIndex {
    return NotificationList.length;
  }

  get getNotificationList {
    return NotificationList;
  }

  List<Product> searchList = [];
  void getSearchList({required List<Product> List}) {
    searchList = List;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query) ||
          element.name.contains(query);
    }).toList();
    return searchShirt;
  }
}
