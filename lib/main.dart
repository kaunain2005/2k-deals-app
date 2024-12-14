import 'package:deals/screens/ecommerce_sites/ecommerce_sites.dart';
import 'package:deals/screens/main_page.dart';
import 'package:deals/startScreen/onboarding_screen.dart';
import 'package:deals/startScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:deals/services/wishlist_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistService()), // Provide WishlistService
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}