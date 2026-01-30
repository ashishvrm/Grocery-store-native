import 'package:flutter/material.dart';
import '../../core/cart/cart_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/demo_data.dart';
import '../../core/theme/app_colors.dart';
import 'delivery_slot_screen.dart';
import 'payment_method_screen.dart';
import 'shipping_address_screen.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AddressItem selectedAddress = demoAddresses.first;
  PaymentMethodItem selectedPayment = demoPaymentMethods.first;
  DeliverySlotItem selectedSlot = demoDeliverySlots.first;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final cartItems = cart.items;
    final subtotal = cartItems.fold<double>(0, (sum, item) {
      return sum + item.total;
    });
    const deliveryFee = 1.5;
    final total = subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _CheckoutSection(
            title: 'Delivery address',
            actionLabel: 'Change',
            onAction: () async {
              final result = await Navigator.push<AddressItem>(
                context,
                MaterialPageRoute(
                  builder: (_) => ShippingAddressScreen(
                    selectedAddress: selectedAddress,
                  ),
                ),
              );
              if (result != null) {
                setState(() => selectedAddress = result);
              }
            },
            child: _AddressCard(address: selectedAddress),
          ),
          _CheckoutSection(
            title: 'Delivery slot',
            actionLabel: 'Edit',
            onAction: () async {
              final result = await Navigator.push<DeliverySlotItem>(
                context,
                MaterialPageRoute(
                  builder: (_) => DeliverySlotScreen(
                    selectedSlot: selectedSlot,
                  ),
                ),
              );
              if (result != null) {
                setState(() => selectedSlot = result);
              }
            },
            child: _SlotCard(slot: selectedSlot),
          ),
          _CheckoutSection(
            title: 'Payment method',
            actionLabel: 'Change',
            onAction: () async {
              final result = await Navigator.push<PaymentMethodItem>(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentMethodScreen(
                    selectedMethod: selectedPayment,
                  ),
                ),
              );
              if (result != null) {
                setState(() => selectedPayment = result);
              }
            },
            child: _PaymentCard(method: selectedPayment),
          ),
          _CheckoutSection(
            title: 'Order summary',
            actionLabel: 'Details',
            onAction: () {},
            child: Column(
              children: [
                _SummaryRow(label: 'Subtotal', value: subtotal),
                const SizedBox(height: AppSpacing.xs),
                const _SummaryRow(label: 'Delivery fee', value: deliveryFee),
                const Divider(height: AppSpacing.lg),
                _SummaryRow(label: 'Total', value: total, bold: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Items',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (cartItems.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Your cart is empty. Add items to place an order.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          else
            ...cartItems.map(
              (item) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(Icons.shopping_bag_rounded,
                        color: AppColors.primary),
                  ),
                  title: Text(item.product.name),
                  subtitle: Text('${item.product.unit} • x${item.quantity}'),
                  trailing: Text('\$${item.total.toStringAsFixed(2)}'),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: ElevatedButton(
            onPressed: cartItems.isEmpty
                ? null
                : () {
                    cart.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderSuccessScreen(),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text('Place order'),
          ),
        ),
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({
    required this.title,
    required this.actionLabel,
    required this.onAction,
    required this.child,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              TextButton(onPressed: onAction, child: Text(actionLabel)),
            ],
          ),
          child,
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final AddressItem address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.label,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(address.address,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          if (address.isDefault)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Default'),
            ),
        ],
      ),
    );
  }
}

class _SlotCard extends StatelessWidget {
  const _SlotCard({required this.slot});

  final DeliverySlotItem slot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_rounded, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(slot.label, style: Theme.of(context).textTheme.titleMedium),
                Text(slot.timeRange,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({required this.method});

  final PaymentMethodItem method;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(method.icon, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(method.label,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(method.detail,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final double value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? Theme.of(context).textTheme.titleMedium
        : Theme.of(context).textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${value.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
