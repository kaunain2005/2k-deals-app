import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistService with ChangeNotifier {
  List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  void addToWishlist(Product product) {
    _wishlist.add(product);
    notifyListeners();
  }

  void removeFromWishlist(Product product) {
    _wishlist.remove(product);
    notifyListeners();
  }

  bool isInWishlist(Product product) {
    return _wishlist.contains(product);
  }
}
