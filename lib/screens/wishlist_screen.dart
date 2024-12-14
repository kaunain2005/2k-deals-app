import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/wishlist_service.dart';
import '../widgets/wishlist_card.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
      ),
      body: Consumer<WishlistService>(
        builder: (context, wishlistService, child) {
          return wishlistService.wishlist.isEmpty
              ? const Center(child: Text('Your wishlist is empty.'))
              : ListView.builder(
                  itemCount: wishlistService.wishlist.length,
                  itemBuilder: (context, index) {
                    return WishlistCard(product: wishlistService.wishlist[index]);
                  },
                );
        },
      ),
    );
  }
}
