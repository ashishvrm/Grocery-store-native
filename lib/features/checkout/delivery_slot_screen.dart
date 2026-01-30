import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/demo_data.dart';
import '../../core/theme/app_colors.dart';

class DeliverySlotScreen extends StatefulWidget {
  const DeliverySlotScreen({super.key, required this.selectedSlot});

  final DeliverySlotItem selectedSlot;

  @override
  State<DeliverySlotScreen> createState() => _DeliverySlotScreenState();
}

class _DeliverySlotScreenState extends State<DeliverySlotScreen> {
  late DeliverySlotItem selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedSlot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery slot'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Choose a convenient slot',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          ...demoDeliverySlots.map(
            (slot) => Card(
              child: RadioListTile<DeliverySlotItem>(
                value: slot,
                groupValue: selected,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selected = value);
                  }
                },
                title: Text(slot.label),
                subtitle: Text(slot.timeRange),
                secondary: const Icon(Icons.timer_rounded,
                    color: AppColors.primary),
              ),
            ),
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
            child: const Text('Save slot'),
          ),
        ),
      ),
    );
  }
}
