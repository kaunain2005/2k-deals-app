  class Product {
    final String asin;
    final String? brand;
    final String title;
    final String availability;
    final String? sellerName;
    final double finalPrice;
    final double initialPrice;
    final String discount;
    final String imageUrl;
    final String url;
    
    Product({
      required this.asin,
      this.brand,
      required this.title,
      required this.availability,
      this.sellerName,
      required this.finalPrice,
      required this.initialPrice,
      required this.discount,
      required this.imageUrl,
      required this.url,
    });

    factory Product.fromJson(Map<String, dynamic> json) {
      return Product(
        asin: json['asin'],
        brand: json['brand'] ?? "",
        title: json['title'],
        availability: json['availability'] ?? "",
        sellerName: json['seller_name'] ?? "",
        finalPrice: json['final_price'].toDouble(),
        initialPrice: json['initial_price'].toDouble(),
        discount: json['discount'],
        imageUrl: json['image_url'],
        url: json['url'],
      );
    }
  }
