import 'package:flutter/material.dart';
import '../core/auth/auth_controller.dart';
import '../core/auth/auth_scope.dart';
import '../core/cart/cart_controller.dart';
import '../core/cart/cart_scope.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/auth_flow.dart';
import '../features/navigation/main_navigation_shell.dart';

class GroceryStoreApp extends StatefulWidget {
  const GroceryStoreApp({super.key});

  @override
  State<GroceryStoreApp> createState() => _GroceryStoreAppState();
}

class _GroceryStoreAppState extends State<GroceryStoreApp> {
  late final CartController _cartController;
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _cartController = CartController();
    _authController = AuthController();
  }

  @override
  void dispose() {
    _cartController.dispose();
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      controller: _authController,
      child: CartScope(
        controller: _cartController,
        child: MaterialApp(
          title: 'Grocery Store',
          theme: AppTheme.light(),
          home: AnimatedBuilder(
            animation: _authController,
            builder: (context, _) {
              return _authController.isSignedIn
                  ? const MainNavigationShell()
                  : const AuthFlow();
            },
          ),
        ),
      ),
    );
  }
}
