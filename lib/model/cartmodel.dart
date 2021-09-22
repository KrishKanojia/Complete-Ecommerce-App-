import 'package:flutter/material.dart';

class CartModel {
  late String name;
  late String image;
  late String color;
  late String size;
  late int quantity;
  late double price;
  CartModel({
    required this.name,
    required this.image,
    required this.color,
    required this.size,
    required this.quantity,
    required this.price,
  });
}
