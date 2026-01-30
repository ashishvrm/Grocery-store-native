import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'How can we help?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          _HelpCard(
            icon: Icons.local_shipping_outlined,
            title: 'Order issues',
            description: 'Missing items, delays, or delivery questions.',
          ),
          _HelpCard(
            icon: Icons.payment_outlined,
            title: 'Payments & refunds',
            description: 'Refund status, failed payments, and invoices.',
          ),
          _HelpCard(
            icon: Icons.shopping_basket_outlined,
            title: 'Product availability',
            description: 'Substitutions, out-of-stock items, and requests.',
          ),
          _HelpCard(
            icon: Icons.support_agent_rounded,
            title: 'Chat with support',
            description: 'Get instant help from our concierge team.',
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.call_rounded),
            label: const Text('Call support'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
