import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import 'app_settings_screen.dart';
import 'help_support_screen.dart';
import 'payment_methods_screen.dart';
import 'profile_screen.dart';
import 'saved_addresses_screen.dart';
import '../../core/auth/auth_scope.dart';
import '../notifications/notifications_screen.dart';
import '../offers/offers_screen.dart';
import '../reviews/reviews_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.lg),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.primary.withOpacity(0.12),
                    child: const Icon(Icons.person_rounded,
                        color: AppColors.primary),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Aarav Sharma',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('aarav@email.com',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _AccountTile(
            icon: Icons.location_on_rounded,
            title: 'Saved Addresses',
            subtitle: 'Home, Office',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SavedAddressesScreen(),
                ),
              );
            },
          ),
          _AccountTile(
            icon: Icons.payment_rounded,
            title: 'Payment Methods',
            subtitle: 'Visa ••45',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentMethodsScreen(),
                ),
              );
            },
          ),
          _AccountTile(
            icon: Icons.notifications_rounded,
            title: 'Notifications',
            subtitle: 'Order updates enabled',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          _AccountTile(
            icon: Icons.local_offer_rounded,
            title: 'Offers & Coupons',
            subtitle: 'Apply savings on your cart',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OffersScreen()),
              );
            },
          ),
          _AccountTile(
            icon: Icons.rate_review_rounded,
            title: 'Reviews',
            subtitle: 'Share your feedback',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReviewsScreen()),
              );
            },
          ),
          _AccountTile(
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            subtitle: 'FAQ, chat with us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            },
          ),
          _AccountTile(
            icon: Icons.settings_rounded,
            title: 'App Settings',
            subtitle: 'Language, theme',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppSettingsScreen()),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton(
            onPressed: () {
              AuthScope.of(context).signOut();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            ),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
