import 'package:flutter/material.dart';
import '../constants/demo_data.dart';

class CartItem {
  CartItem({
    required this.product,
    required this.quantity,
  });

  final ProductItem product;
  int quantity;

  double get total => product.price * quantity;
}

class CartController extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList(growable: false);

  int get itemCount =>
      _items.values.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold<double>(0, (sum, item) => sum + item.total);

  void addProduct(ProductItem product, {int quantity = 1}) {
    if (quantity <= 0) {
      return;
    }
    final existing = _items[product.id];
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _items[product.id] = CartItem(product: product, quantity: quantity);
    }
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (quantity <= 0) {
      _items.remove(productId);
    } else {
      _items[productId]!.quantity = quantity;
    }
    notifyListeners();
  }

  void removeProduct(String productId) {
    if (_items.remove(productId) != null) {
      notifyListeners();
    }
  }

  void clear() {
    if (_items.isNotEmpty) {
      _items.clear();
      notifyListeners();
    }
  }
}
