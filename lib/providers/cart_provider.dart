import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

/// SINGLE CART ITEM
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  /// Convert CartItem → JSON
  Map<String, dynamic> toJson() {
    return {
      'product': {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'image': product.image,
        'category': product.category,
      },
      'quantity': quantity,
    };
  }

  /// Convert JSON → CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product(
        id: json['product']['id'],
        title: json['product']['title'],
        price: (json['product']['price'] as num).toDouble(),
        description: json['product']['description'],
        image: json['product']['image'],
        category: json['product']['category'],
      ),
      quantity: json['quantity'],
    );
  }
}

/// CART PROVIDER (WITH LOCAL STORAGE)
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  /// Constructor
  /// App start hote hi cart load karo
  CartProvider() {
    loadCartFromStorage();
  }

  List<CartItem> get items => _items;

  /// ADD TO CART
  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }

    saveCartToStorage();
    notifyListeners();
  }

  /// UPDATE QUANTITY
  void updateQuantity(Product product, int qty) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      if (qty <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = qty;
      }

      saveCartToStorage();
      notifyListeners();
    }
  }

  /// TOTAL PRICE
  double get totalPrice {
    double sum = 0;
    for (var item in _items) {
      sum += item.product.price * item.quantity;
    }
    return sum;
  }

  /// CLEAR CART
  void clearCart() {
    _items.clear();
    saveCartToStorage();
    notifyListeners();
  }

  // -------------------------------
  // LOCAL STORAGE LOGIC
  // -------------------------------

  /// SAVE CART TO DEVICE
  Future<void> saveCartToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final cartJson = _items.map((item) => item.toJson()).toList();

    prefs.setString('cart_items', jsonEncode(cartJson));
  }

  /// LOAD CART FROM DEVICE
  Future<void> loadCartFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final cartString = prefs.getString('cart_items');

    if (cartString != null) {
      final List decoded = jsonDecode(cartString);

      _items.clear();
      _items.addAll(decoded.map((e) => CartItem.fromJson(e)).toList());

      notifyListeners();
    }
  }
}
