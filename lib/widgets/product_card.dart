import 'package:flutter/material.dart';
import '../models/product.dart';

/// PRODUCT CARD (POLISHED UI)
/// --------------------------
/// Ye widget ab modern e-commerce jaisa dikhega
class ProductCard extends StatelessWidget {
  final Product product;

  /// Card tap (navigate to detail)
  final VoidCallback onTap;

  /// Add to cart button tap
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Card(
        elevation: 4, // shadow depth (premium feel)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // rounded corners
        ),

        child: Padding(
          padding: const EdgeInsets.all(10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// PRODUCT IMAGE
              Expanded(
                child: Center(
                  child: Image.network(product.image, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 8),

              /// PRODUCT TITLE
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// PRICE
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 8),

              /// ADD TO CART BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAddToCart,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 126, 189, 241),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),

                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
