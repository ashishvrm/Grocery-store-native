import 'package:flutter/material.dart';
import '../../core/auth/auth_scope.dart';
import 'welcome_screen.dart';
import 'otp_screen.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(
            onContinue: (phone) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                    phoneNumber: phone,
                    onVerified: () => AuthScope.of(context).signIn(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
