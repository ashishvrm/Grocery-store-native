import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool orderUpdates = true;
  bool deliveryStatus = true;
  bool promos = true;
  bool recommendations = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Stay up to date',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile(
            value: orderUpdates,
            onChanged: (value) => setState(() => orderUpdates = value),
            title: const Text('Order updates'),
            subtitle: const Text('Order placed, packed, and delivered'),
          ),
          SwitchListTile(
            value: deliveryStatus,
            onChanged: (value) => setState(() => deliveryStatus = value),
            title: const Text('Delivery status'),
            subtitle: const Text('Live delivery tracking notifications'),
          ),
          SwitchListTile(
            value: promos,
            onChanged: (value) => setState(() => promos = value),
            title: const Text('Offers & promotions'),
            subtitle: const Text('Coupons, rewards, and savings'),
          ),
          SwitchListTile(
            value: recommendations,
            onChanged: (value) => setState(() => recommendations = value),
            title: const Text('Recommendations'),
            subtitle: const Text('Personalized product picks'),
          ),
        ],
      ),
    );
  }
}
