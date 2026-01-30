import 'package:flutter/material.dart';
import 'cart_controller.dart';

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    super.key,
    required CartController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static CartController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found in widget tree');
    return scope!.notifier!;
  }
}
