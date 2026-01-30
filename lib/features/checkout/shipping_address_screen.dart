import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/demo_data.dart';
import '../../core/theme/app_colors.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key, required this.selectedAddress});

  final AddressItem selectedAddress;

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  late AddressItem selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          ...demoAddresses.map(
            (address) => Card(
              child: RadioListTile<AddressItem>(
                value: address,
                groupValue: selected,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selected = value);
                  }
                },
                title: Text(address.label),
                subtitle: Text(address.address),
                secondary: Icon(Icons.location_on_rounded,
                    color: address.isDefault
                        ? AppColors.primary
                        : AppColors.textSecondary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_location_alt_rounded),
            label: const Text('Add new address'),
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
            child: const Text('Save address'),
          ),
        ),
      ),
    );
  }
}
