import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/demo_data.dart';
import '../../core/theme/app_colors.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, required this.selectedMethod});

  final PaymentMethodItem selectedMethod;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late PaymentMethodItem selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment method'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Select a payment option',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          ...demoPaymentMethods.map(
            (method) => Card(
              child: RadioListTile<PaymentMethodItem>(
                value: method,
                groupValue: selected,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selected = value);
                  }
                },
                title: Text(method.label),
                subtitle: Text(method.detail),
                secondary: Icon(method.icon, color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_card_rounded),
            label: const Text('Add new payment method'),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context, selected),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('Save method'),
          ),
        ),
      ),
    );
  }
}
