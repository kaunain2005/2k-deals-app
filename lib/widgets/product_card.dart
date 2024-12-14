import 'dart:async';
import 'package:flutter/material.dart';
import 'package:deals/screens/product_detail_page.dart';
import 'package:share_plus/share_plus.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onLike;
  final bool isLiked;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onLike,
    required this.isLiked,
  }) : super(key: key);

  void _shareProduct(BuildContext context) {
    Share.share('Check out this product: ${product.url}');
  }

  void _viewProductDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title, style: TextStyle(fontSize: 14)),
                    SizedBox(height: 5),
                    Text("Price: ₹${product.finalPrice}", style: TextStyle(color: Colors.green)),
                    // Additional product details like brand can be added here
                    Row(
              children: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => _shareProduct(context),
                ),
                IconButton(
                  icon: Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.grey),
                  onPressed: () {
                    onLike(product); // Call onLike function to toggle like state
                  },
                ),
                TextButton(
                  onPressed: () => _viewProductDetail(context),
                  child: Text('View Detail'),
                ),
              ],
            ),
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

