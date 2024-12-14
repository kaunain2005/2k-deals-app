import 'package:deals/screens/ecommerce_sites/ecommerce_sites.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

import 'home_screen.dart';
import 'wishlist_screen.dart';
import 'product_section/product_detection_page.dart';
import 'profile_screen.dart';
import '../models/product.dart';
import '../services/wishlist_service.dart';

Future<List<Product>> fetchProducts() async {
  final jsondata = await rootBundle.rootBundle.loadString('assets/products.json');
  final List<dynamic> data = json.decode(jsondata);
  return data.map((product) => Product.fromJson(product)).toList();
}


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WishlistService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
   @override
  bool get wantKeepAlive => true; 

  int _bottomNavIndex = 0;
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
  }

  // Icon list for the bottom navigation bar
  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.search,
    Icons.person,
  ];

  // Colors for each tab
  final List<Color> tabColors = [
    Color.fromARGB(255, 29, 4, 172), // Color for the first tab (Home)
    Colors.red, // Color for the second tab (Favorite)
    Color.fromARGB(255, 29, 4, 172), // Color for the third tab (Search)
    Color.fromARGB(255, 29, 4, 172), // Color for the fourth tab (Profile)
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return FutureBuilder<List<Product>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // List of destination widgets, passing the products to HomeScreen
        final List<Widget> _screens = [
          HomeScreen(products: snapshot.data!),  // Pass products to HomeScreen
          WishlistScreen(),
          MyBrowser(),
          ProfileScreen(),
        ];

        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: Image.asset(
                'assets/images/logo7rm.png', // Path to your logo asset
                fit: BoxFit.contain,
              ),
            ),
            backgroundColor: Color.fromARGB(255, 255, 255, 255), // AppBar background color
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  // Action for notifications
                },
              ),
            ],
          ),
          body: _screens[_bottomNavIndex], // Display selected screen
          //! Conditionally show the floating button only if the keyboard is not visible
          floatingActionButton: isKeyboardVisible
              ? null //! If the keyboard is visible, hide the button
              : FloatingActionButton(
                  onPressed: () {
                    // Action for the FloatingActionButton
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductDetectionPage()),
                    );
                  },
                  child: Icon(
                    Icons.camera_outlined,
                    color: Colors.white, // Set the icon color to white
                  ),
                  backgroundColor: Color.fromARGB(255, 29, 4, 172),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Ensures it's round
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              return Icon(
                iconList[index],
                size: 28,
                color: isActive
                    ? tabColors[index] // Active color for each tab
                    : Colors.grey, // Inactive color
              );
            },
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (index) => setState(() => _bottomNavIndex = index),
          ),
        );
      },
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Screen'));
  }
}
