import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:deals/auth/auth_screen.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  Color backgroundColor = const Color.fromARGB(255, 237, 231, 235);

  final List<Color> _bgColors = [
    const Color.fromARGB(255, 237, 231, 235), // Page 1
    const Color.fromARGB(255, 154, 205, 178), // Page 2
    const Color.fromARGB(255, 255, 255, 255), // Page 3
    const Color.fromARGB(255, 255, 255, 255), // Page 4
  ];

  @override
  void initState() {
    super.initState();

    // Listen to PageController scroll changes for smooth color transitions
    _controller.addListener(() {
      setState(() {
        // Calculate the current page and its fractional part
        double page = _controller.page ?? 0.0;
        int currentIndex = page.floor();
        double pageOffset = page - currentIndex;

        // Interpolate between the current and next page colors
        if (currentIndex < _bgColors.length - 1) {
          backgroundColor = Color.lerp(
            _bgColors[currentIndex],
            _bgColors[currentIndex + 1],
            pageOffset,
          )!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Use AnimatedContainer for smooth background color transitions
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: backgroundColor, // Set the dynamic background color
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 3; // Assuming 4 pages
                });
              },
              children: [
                buildPage(
                  image: 'assets/images/welcome.gif',
                  title: 'Welcome to 2K Deals',
                  description: 'Find the best deals across multiple platforms.',
                ),
                buildPage(
                  image: 'assets/images/Shopcart2.gif',
                  title: 'Get the Latest Discounts',
                  description:
                      'Stay updated with the latest discounts and offers.',
                ),
                buildPage(
                  image: 'assets/images/money.gif',
                  title: 'Compare Prices',
                  description:
                      'Easily compare prices from different e-commerce sites.',
                ),
                buildPage(
                  image: 'assets/images/scroll.gif',
                  title: 'Start Saving',
                  description: 'Save on every purchase with our curated deals.',
                ),
              ],
            ),
          ),

          // Circular Dots Indicator
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: const WormEffect(
                  dotHeight: 8, // Adjust the height of dots
                  dotWidth: 8, // Adjust the width of dots
                  activeDotColor: Color.fromARGB(255, 21, 0, 139),
                  dotColor: Colors.grey,
                  spacing: 16, // Spacing between dots
                ),
              ),
            ),
          ),

          // "Next" or "Continue" Button
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (isLastPage) {
                  // Navigate to main page
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  // Move to the next page
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: isLastPage
                      ? Colors.transparent
                      : Color.fromARGB(255, 21, 0, 139),
                  width: 2,
                ),
                backgroundColor:
                    isLastPage ? Color.fromARGB(255, 21, 0, 139) : Colors.white,
                foregroundColor:
                    isLastPage ? Colors.white : Color.fromARGB(255, 21, 0, 139),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                isLastPage ? "Continue" : "Next",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each page
  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
