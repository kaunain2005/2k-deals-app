import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:webview_all/webview_all.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Image.network(product.imageUrl, height: 200, width: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.title, style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Price: ₹${product.finalPrice}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Price: ₹${product.discount}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Price: ₹${product.availability}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Price: ₹${product.brand}"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductWebView(url: product.url),
                ),
              );
            },
            child: Text('Visit Product'),
          ),
        ],
      ),
    );
  }
}

// ProductWebView to display the selected e-commerce site
class ProductWebView extends StatelessWidget {
  final String url;

  const ProductWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Webview(
        url: url, // Load the selected e-commerce site
      ),
    );
  }
}