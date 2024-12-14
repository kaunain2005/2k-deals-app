import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/wishlist_service.dart';
import '../widgets/product_card.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  final List<Product> products; // Pass the products to this widget

  HomeScreen({required this.products});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _searchQuery = '';
  final TextEditingController _controller = TextEditingController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;

  static const _pageSize = 20;
  final PagingController<int, Product> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _initSpeech();

    // Add listener for page requests
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  //! Fetch data when a new page is requested
  Future<void> _fetchPage(int pageKey) async {
    try {
      // Filter products based on the search query
      final filteredProducts = widget.products.where((product) {
        return product.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();

      // Simulate fetching products from an API or local data source
      final newProducts = await Future.delayed(Duration(milliseconds: 500), () {
        return filteredProducts.skip(pageKey).take(_pageSize).toList(); // Paginate the filtered products
      });

      final isLastPage = newProducts.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newProducts);
      } else {
        final nextPageKey = pageKey + newProducts.length;
        _pagingController.appendPage(newProducts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  //! This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  //! Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  //! This is the callback that the SpeechToText plugin calls when
  //! the platform returns recognized words.
  void _onSpeechResult(result) {
    setState(() {
      _searchQuery = "${result.recognizedWords}";
      _controller.text = _searchQuery;
      _pagingController.refresh(); // Refresh the PagedListView to reflect the new search query
    });
  }

  //! Stop listening method
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      _pagingController.refresh(); // Refresh the PagedListView to reflect the new search query
    });
  }

  @override
  Widget build(BuildContext context) {
    //! Make call super.build when using AutomaticKeepAliveClientMixin
    super.build(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: _filterProducts,
                    decoration: const InputDecoration(
                      hintText: 'Search products...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _speechToText.isNotListening ? Icons.mic : Icons.mic_none,
                    color: _speechToText.isListening
                        ? Color.fromARGB(255, 21, 0, 139)
                        : Color.fromARGB(255, 73, 69, 69),
                  ),
                  onPressed: _speechToText.isListening
                      ? _stopListening
                      : _startListening,
                  tooltip: 'Speak to search',
                ),
              ],
            ),
          ),
          Expanded(
            child: PagedListView<int, Product>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Product>(
                itemBuilder: (context, product, index) => ProductCard(
                  product: product,
                  onLike: (product) {
                    final wishlistService = Provider.of<WishlistService>(context, listen: false);
                    wishlistService.isInWishlist(product)
                        ? wishlistService.removeFromWishlist(product)
                        : wishlistService.addToWishlist(product);
                  },
                  isLiked: Provider.of<WishlistService>(context).isInWishlist(product),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose(); // Dispose of paging controller
    super.dispose();
  }
}
