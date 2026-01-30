import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import 'notification_settings_screen.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool orderUpdates = true;
  bool promoAlerts = true;
  bool darkMode = false;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Preferences',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile(
            value: orderUpdates,
            onChanged: (value) => setState(() => orderUpdates = value),
            title: const Text('Order updates'),
            subtitle: const Text('Get delivery and status notifications'),
          ),
          SwitchListTile(
            value: promoAlerts,
            onChanged: (value) => setState(() => promoAlerts = value),
            title: const Text('Promotions'),
            subtitle: const Text('Receive offers and coupons'),
          ),
          SwitchListTile(
            value: darkMode,
            onChanged: (value) => setState(() => darkMode = value),
            title: const Text('Dark mode'),
            subtitle: const Text('Use a darker color scheme'),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Language',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              border: Border.all(color: AppColors.divider),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: language,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(value: 'Hindi', child: Text('Hindi')),
                  DropdownMenuItem(value: 'Marathi', child: Text('Marathi')),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => language = value);
                },
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationSettingsScreen(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            ),
            child: const Text('Manage notification settings'),
          ),
        ],
      ),
    );
  }
}
