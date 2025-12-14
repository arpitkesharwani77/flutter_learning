import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  List<String> categories = [];
  String selectedCategory = 'all';
  String searchText = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  void loadInitialData() async {
    final fetchedCategories = await ProductService.fetchCategories();
    final fetchedProducts = await ProductService.fetchAllProducts();

    setState(() {
      categories = ['all', ...fetchedCategories];
      products = fetchedProducts;
      isLoading = false;
    });
  }

  void loadProductsByCategory(String category) async {
    setState(() => isLoading = true);

    if (category == 'all') {
      products = await ProductService.fetchAllProducts();
    } else {
      products = await ProductService.fetchByCategory(category);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final filteredProducts = products.where((product) {
      return product.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("MiniShop"),
        centerTitle: true,
        elevation: 0,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                /// SEARCH BAR (POLISHED)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() => searchText = value);
                    },
                  ),
                ),

                /// CATEGORY DROPDOWN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCategory,
                        items: categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => selectedCategory = value);
                          loadProductsByCategory(value);
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// PRODUCT GRID
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.62,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        onAddToCart: () {
                          cart.addToCart(product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
