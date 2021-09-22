import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String Name;

  MyTextFormField({
    required this.Name,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: Name,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
