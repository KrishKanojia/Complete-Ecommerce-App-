import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  late String name;
  TextEditingController controller = TextEditingController();
  late VoidCallback onTap;
  late bool obscureText;

  PasswordTextFormField({
    required this.name,
    required this.obscureText,
    required this.onTap,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: obscureText == true
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
