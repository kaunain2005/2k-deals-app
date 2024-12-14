import 'package:flutter/material.dart';
import 'package:webview_all/webview_all.dart';

class MyBrowser extends StatefulWidget {
  const MyBrowser({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyBrowserState createState() => _MyBrowserState();
}

class _MyBrowserState extends State<MyBrowser> {
  // List of e-commerce sites with their names, URLs, and logo paths
  final List<Map<String, String>> ecommerceSites = [
    {
      'name': 'Amazon',
      'url': 'https://www.amazon.in/',
      'logo': 'assets/icons/amazon.png'
    },
    {
      'name': 'Flipkart',
      'url': 'https://www.flipkart.com/',
      'logo': 'assets/icons/flipkart.png'
    },
    {
      'name': 'Meesho',
      'url': 'https://www.meesho.com/',
      'logo': 'assets/icons/meesho.png'
    },
    {
      'name': 'Snapdeal',
      'url': 'https://www.snapdeal.com/',
      'logo': 'assets/icons/snapdeal.png'
    },
    {
      'name': 'Myntra',
      'url': 'https://www.myntra.com/',
      'logo': 'assets/icons/myntra.png'
    },
  ];

  // Method to open the WebView when a card is pressed
  void _openWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebviewPage(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'E-commerce Browser'),
        backgroundColor: Color.fromARGB(255, 21, 0, 139),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards per row
            childAspectRatio: 1, // Square shape for cards
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: ecommerceSites.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () => _openWebView(ecommerceSites[index]['url']!),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Displaying the logo
                    Image.asset(
                      ecommerceSites[index]['logo']!,
                      height: 80, // Adjust height as needed
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    // Site name
                    Text(
                      ecommerceSites[index]['name']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// WebViewPage to display the selected e-commerce site
class WebviewPage extends StatelessWidget {
  final String url;

  const WebviewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Webview(
        url: url, // Load the selected e-commerce site
      ),
    );
  }
}
