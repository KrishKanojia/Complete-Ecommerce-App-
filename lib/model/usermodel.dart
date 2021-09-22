import 'package:flutter/material.dart';

class UserModel {
  String UserName;
  String UserEmail;
  String UserGender;
  String UserPhoneNumber;
  String UserImage;
  String UserAddress;

  UserModel({
    required this.UserName,
    required this.UserAddress,
    required this.UserEmail,
    required this.UserGender,
    required this.UserPhoneNumber,
    required this.UserImage,
  });
}
