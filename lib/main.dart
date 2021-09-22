import 'package:ecommerce_app/provider/category_provider.dart';
import 'package:ecommerce_app/provider/product_provider.dart';
import 'package:ecommerce_app/screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ListenableProvider<CategoryProvider>(
            create: (ctx) => CategoryProvider(),
          ),
          ListenableProvider<ProductProvider>(
            create: (ctx) => ProductProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Ecommerce App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            // Initialize FlutterFire:
            future: _initialization,
            builder: (context, AsyncSnapshot snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                print(snapshot.error);
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return WelcomeScreen();
              }

              return Container();
            },
          ),
        ));
  }
}
