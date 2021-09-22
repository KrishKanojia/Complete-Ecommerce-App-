import 'package:ecommerce_app/model/categoryicon.dart';
import 'package:ecommerce_app/model/usermodel.dart';
import 'package:ecommerce_app/provider/category_provider.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/aboutus.dart';
import 'package:ecommerce_app/screens/cartscreen.dart';
import 'package:ecommerce_app/screens/contactus.dart';
import 'package:ecommerce_app/screens/detailscreen.dart';
import 'package:ecommerce_app/screens/listproduct.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/profilescreen.dart';
import 'package:ecommerce_app/screens/singleproduct.dart';
import 'package:ecommerce_app/widget/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

late Product menData;
late Product monitorData;
double height = 0.0;
var featuredsnapshot;
var newarchivessnapshot;
var shirtSnapshot;
late CategoryProvider categoryprovider;
late ProductProvider productprovider;

class _HomepageState extends State<Homepage> {
  bool homeColor = true;
  bool cartColor = false;
  bool aboutColor = false;
  bool profileColor = false;
  bool contactColor = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = productprovider.getUserModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        decoration: BoxDecoration(color: Colors.indigo),
        accountName: Text(
          e.UserName,
          style: TextStyle(fontSize: 20),
        ),
        currentAccountPicture: CircleAvatar(
          child: ClipOval(
            child: e.UserImage == ""
                ? Image.asset("assets/UserImage.png")
                : Image.network(
                    "${e.UserImage}",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
          ),
        ),
        accountEmail: Text(
          e.UserEmail,
          style: TextStyle(fontSize: 17),
        ),
      );
    }).toList());
  }

  Widget buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: [
          _buildUserAccountsDrawerHeader(),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                cartColor = false;
                aboutColor = false;
                profileColor = false;

                contactColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Homepage(),
                ),
              );
            },
            leading: Icon(
              Icons.home,
              size: 35,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                profileColor = true;
                contactColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            leading: Icon(
              Icons.person,
              size: 35,
            ),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = true;
                aboutColor = false;
                profileColor = false;

                contactColor = false;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              });
            },
            leading: Icon(
              Icons.shopping_cart,
              size: 35,
            ),
            title: Text(
              "Cart",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = false;
                aboutColor = true;
                profileColor = false;

                contactColor = false;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              });
            },
            leading: Icon(
              Icons.info,
              size: 35,
            ),
            title: Text(
              "About",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            selected: contactColor,
            onTap: () {
              setState(() {
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                profileColor = false;
                contactColor = true;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Contactus(),
                ),
              );
            },
            leading: Icon(
              Icons.phone,
              size: 35,
            ),
            title: Text(
              "Contact Us",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            enabled: true,
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => login(),
                ),
              );
            },
            leading: Icon(
              Icons.exit_to_app,
              size: 35,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory() {
    List<Product> pants = categoryprovider.getPantList();
    List<Product> shirts = categoryprovider.getShirtList();
    List<Product> dresses = categoryprovider.getDressList();
    List<Product> shoes = categoryprovider.getShoeList();
    List<Product> ties = categoryprovider.getTieList();
    List<CategoryIcon> categoryIcon = categoryprovider.getCategoryIconList();
    List category = [
      dresses,
      pants,
      ties,
      shoes,
      shirts,
    ];

    List colors = [
      0xff33dcfd,
      0xfff38cdd,
      0xff4ff2af,
      0xff74acf7,
      0xfffc6c8d,
    ];

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 10,
          ),
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categoryIcon.length,
            itemBuilder: (context, int index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      isCategory: true,
                      name: "${categoryIcon[index].name}",
                      snapshot: category[index],
                    ),
                  ),
                );
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Color(colors[index]),
                        maxRadius: height * 0.1 / 2.1,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: Image(
                            color: Colors.white,
                            image: NetworkImage(
                              "${categoryIcon[index].image}",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFeature() {
    List<Product> features = productprovider.getFeatureList();
    List<Product> homeFeatures = productprovider.getHomeFeatureList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        isCategory: false,
                        name: 'Featured',
                        snapshot: features,
                      ),
                    ),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.blue])),
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeFeatures.length,
              itemBuilder: (context, int index) => Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                1.0, 1.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => DetailScreen(
                                image: homeFeatures[index].image,
                                name: homeFeatures[index].name,
                                price: homeFeatures[index].price,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              width: double.infinity,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                child: Image(
                                  image:
                                      NetworkImage(homeFeatures[index].image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${homeFeatures[index].name}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${homeFeatures[index].price}",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNewArchives() {
    List<Product> newarchives = productprovider.getNewarchivesList();
    List<Product> homeNewarchives = productprovider.getHomeNewarchivesList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Archives",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListProduct(
                        isCategory: false,
                        name: "New Archives",
                        snapshot: newarchives,
                      ),
                    ),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            childAspectRatio: 0.95,
            children: List.generate(
              homeNewarchives.length,
              (index) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: homeNewarchives[index].image,
                            name: homeNewarchives[index].name,
                            price: homeNewarchives[index].price,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              child: Image(
                                image:
                                    NetworkImage(homeNewarchives[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "${homeNewarchives[index].name}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\$ ${newarchives[index].price}",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  var slider = [
    {
      "name": "Jordan 9",
      "image":
          "https://images.unsplash.com/photo-1610870372593-a8647b04451f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmlrZSUyMGpvcmRhbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
      "price": 399.99
    },
    {
      "name": "Iphone 12",
      "image":
          "https://images.unsplash.com/photo-1607936854279-55e8a4c64888?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aXBob25lJTIwMTJ8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
      "price": 899.99
    },
    {
      "name": "Kookabura Bat",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTif_UXdhm9YFMeFr8v02lJ_z1W87dbfgP15w&usqp=CAU",
      "price": 488.1
    },
    {
      "name": "Round Cap",
      "image":
          "https://images.unsplash.com/photo-1589831377283-33cb1cc6bd5d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGNhcHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
      "price": 50.49
    },
    {
      "name": "Playstation 5",
      "image":
          "https://images.unsplash.com/photo-1607853202273-797f1c22a38e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGxheXN0YXRpb24lMjA1fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
      "price": 399.99
    },
  ];

  @override
  Widget build(BuildContext context) {
    categoryprovider = Provider.of<CategoryProvider>(context);
    categoryprovider.getPantData();
    categoryprovider.getShirtData();
    categoryprovider.getDressData();
    categoryprovider.getShoeData();
    categoryprovider.getTieData();
    categoryprovider.getCategoryIconData();

    productprovider = Provider.of<ProductProvider>(context);
    productprovider.getFeatureData();
    productprovider.getNewarchivesData();
    productprovider.getHomeFeatureData();
    productprovider.getHomeNewarchivesData();
    productprovider.getUserData();

    height = MediaQuery.of(context).size.height;
    print("This is Max Radius${height * 0.1 / 2.1}");

    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        title: Text("Ecommerce App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              List<Product> features = productprovider.getFeatureList();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListProduct(
                    isCategory: false,
                    name: 'Featured',
                    snapshot: features,
                  ),
                ),
              );
            },
          ),
          NotificationButton(),
        ],
      ),
      drawer: buildMyDrawer(),

      //

      body: SafeArea(
        child: Container(
          color: Colors.grey[290],
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: CarouselSlider.builder(
                  itemCount: slider.length,
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    viewportFraction: 1.05,
                    autoPlay: true,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                    child: SingleProduct(
                      name: slider[itemIndex]["name"].toString(),
                      image: "${slider[itemIndex]["image"].toString()}",
                      price: slider[itemIndex]["price"] as double,
                    ),
                  ),
                ),
              ),
              buildCategory(),
              buildFeature(),
              buildNewArchives(),
            ],
          ),
        ),
      ),
    );
  }
}
