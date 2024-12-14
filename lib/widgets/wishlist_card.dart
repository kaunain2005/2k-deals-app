import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/wishlist_service.dart';

class WishlistCard extends StatelessWidget {
  final Product product;

  const WishlistCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(product.title),
        subtitle: Text("Price: ₹${product.finalPrice}"),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Access the WishlistService and remove the product
            Provider.of<WishlistService>(context, listen: false).removeFromWishlist(product);
          },
        ),
      ),
    );
  }
}
