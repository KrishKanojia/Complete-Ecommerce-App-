import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/provider/category_provider.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of(context);
    List<Product> searchProduct = categoryProvider.searchCategoryList(query);

    return GridView.count(
      childAspectRatio: 0.87,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map((e) => SingleProduct(
                name: e.name,
                image: e.image,
                price: e.price,
                description: e.description,
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    List<Product> searchProduct = productProvider.searchProductList(query);

    return GridView.count(
      childAspectRatio: 0.87,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map((e) => SingleProduct(
                name: e.name,
                image: e.image,
                price: e.price,
                description: e.description,
              ))
          .toList(),
    );
  }
}
