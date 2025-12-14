import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// PRODUCT SERVICE
/// ---------------
/// Is file ka kaam:
/// - API calls
/// - JSON parsing
/// - UI ko clean data dena
class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com';

  /// Fetch ALL products
  static Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  /// Fetch categories (electronics, jewelery, etc.)
  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }

  /// Fetch products by category
  static Future<List<Product>> fetchByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/category/$category'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load category products');
    }
  }
}
