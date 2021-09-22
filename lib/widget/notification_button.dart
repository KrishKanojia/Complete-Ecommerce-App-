import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      animationType: BadgeAnimationType.slide,
      position: BadgePosition(top: 10, end: 4),
      badgeColor: Colors.red,
      badgeContent: Text(
        productProvider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      child: IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: Colors.white,
          ),
          onPressed: () {}),
    );
  }
}
