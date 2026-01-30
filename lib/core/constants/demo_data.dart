import '../theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItem {
  const CategoryItem({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String id;
  final String title;
  final IconData icon;
}

class ProductItem {
  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.rating,
    required this.reviewCount,
    required this.imageLabel,
    this.discountLabel,
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final String unit;
  final double rating;
  final int reviewCount;
  final String imageLabel;
  final String? discountLabel;
}

class ReviewItem {
  const ReviewItem({
    required this.user,
    required this.rating,
    required this.comment,
    required this.timeAgo,
  });

  final String user;
  final double rating;
  final String comment;
  final String timeAgo;
}

class AddressItem {
  const AddressItem({
    required this.id,
    required this.label,
    required this.address,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String address;
  final bool isDefault;
}

class PaymentMethodItem {
  const PaymentMethodItem({
    required this.id,
    required this.label,
    required this.detail,
    required this.icon,
  });

  final String id;
  final String label;
  final String detail;
  final IconData icon;
}

class DeliverySlotItem {
  const DeliverySlotItem({
    required this.id,
    required this.label,
    required this.timeRange,
  });

  final String id;
  final String label;
  final String timeRange;
}

class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    this.isUnread = false,
  });

  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final bool isUnread;
}

class CouponItem {
  const CouponItem({
    required this.code,
    required this.title,
    required this.description,
    required this.savings,
  });

  final String code;
  final String title;
  final String description;
  final String savings;
}

class OrderStatusStep {
  const OrderStatusStep({
    required this.title,
    required this.subtitle,
    required this.isComplete,
  });

  final String title;
  final String subtitle;
  final bool isComplete;
}

const demoCategories = [
  CategoryItem(id: 'c1', title: 'Fruits', icon: Icons.apple),
  CategoryItem(id: 'c2', title: 'Vegetables', icon: Icons.spa),
  CategoryItem(id: 'c3', title: 'Dairy', icon: Icons.icecream),
  CategoryItem(id: 'c4', title: 'Bakery', icon: Icons.bakery_dining),
  CategoryItem(id: 'c5', title: 'Snacks', icon: Icons.cookie),
  CategoryItem(id: 'c6', title: 'Beverages', icon: Icons.local_drink),
];

const demoProducts = [
  ProductItem(
    id: 'p1',
    name: 'Fresh Apple',
    category: 'Fruits',
    price: 2.49,
    unit: '500 g',
    rating: 4.6,
    reviewCount: 210,
    imageLabel: 'Apple Basket',
    discountLabel: '10% OFF',
  ),
  ProductItem(
    id: 'p2',
    name: 'Organic Banana',
    category: 'Fruits',
    price: 1.79,
    unit: '6 pcs',
    rating: 4.4,
    reviewCount: 156,
    imageLabel: 'Banana Bunch',
  ),
  ProductItem(
    id: 'p3',
    name: 'Tomatoes',
    category: 'Vegetables',
    price: 1.25,
    unit: '1 kg',
    rating: 4.2,
    reviewCount: 98,
    imageLabel: 'Tomatoes',
  ),
  ProductItem(
    id: 'p4',
    name: 'Whole Milk',
    category: 'Dairy',
    price: 0.99,
    unit: '1 L',
    rating: 4.7,
    reviewCount: 320,
    imageLabel: 'Milk Carton',
    discountLabel: '15% OFF',
  ),
  ProductItem(
    id: 'p5',
    name: 'Croissant Pack',
    category: 'Bakery',
    price: 3.25,
    unit: '4 pcs',
    rating: 4.5,
    reviewCount: 80,
    imageLabel: 'Croissants',
  ),
  ProductItem(
    id: 'p6',
    name: 'Potato Chips',
    category: 'Snacks',
    price: 2.15,
    unit: '150 g',
    rating: 4.1,
    reviewCount: 140,
    imageLabel: 'Chips',
  ),
];

const demoReviews = [
  ReviewItem(
    user: 'Anita',
    rating: 5,
    comment: 'Super fresh and delivered quickly!',
    timeAgo: '2 days ago',
  ),
  ReviewItem(
    user: 'Rahul',
    rating: 4.5,
    comment: 'Quality is great. Packaging was neat.',
    timeAgo: '1 week ago',
  ),
  ReviewItem(
    user: 'Isha',
    rating: 4,
    comment: 'Good value for money.',
    timeAgo: '2 weeks ago',
  ),
];

const demoAddresses = [
  AddressItem(
    id: 'a1',
    label: 'Home',
    address: 'Sai Park, Building 2, Pune 411001',
    isDefault: true,
  ),
  AddressItem(
    id: 'a2',
    label: 'Office',
    address: 'Tech Park, Hinjewadi Phase 2, Pune 411057',
    isDefault: false,
  ),
];

const demoPaymentMethods = [
  PaymentMethodItem(
    id: 'p1',
    label: 'Visa',
    detail: '**** 4521',
    icon: Icons.credit_card,
  ),
  PaymentMethodItem(
    id: 'p2',
    label: 'UPI',
    detail: 'aarav@upi',
    icon: Icons.account_balance_wallet,
  ),
  PaymentMethodItem(
    id: 'p3',
    label: 'Cash',
    detail: 'Pay on delivery',
    icon: Icons.money,
  ),
];

const demoDeliverySlots = [
  DeliverySlotItem(id: 's1', label: 'Today', timeRange: '2:00 - 4:00 PM'),
  DeliverySlotItem(id: 's2', label: 'Today', timeRange: '5:00 - 7:00 PM'),
  DeliverySlotItem(id: 's3', label: 'Tomorrow', timeRange: '9:00 - 11:00 AM'),
];

const demoNotifications = [
  NotificationItem(
    id: 'n1',
    title: 'Order delivered',
    body: 'Order #1001 has been delivered. Rate your items.',
    timeAgo: '10 min ago',
    isUnread: true,
  ),
  NotificationItem(
    id: 'n2',
    title: 'Fresh deals',
    body: 'Get 20% off on snacks with code CRUNCH20.',
    timeAgo: '2 hours ago',
  ),
  NotificationItem(
    id: 'n3',
    title: 'Delivery on the way',
    body: 'Your rider is 8 minutes away.',
    timeAgo: 'Yesterday',
  ),
];

const demoCoupons = [
  CouponItem(
    code: 'SAVE15',
    title: 'Save 15% on staples',
    description: 'Valid on orders above \\$20. Grocery essentials only.',
    savings: 'Up to \\$6',
  ),
  CouponItem(
    code: 'FRESH10',
    title: 'Fresh produce deal',
    description: '10% off on fruits and veggies. Today only.',
    savings: 'Up to \\$4',
  ),
  CouponItem(
    code: 'CRUNCH20',
    title: 'Snack time',
    description: '20% off on chips, cookies, and munchies.',
    savings: 'Up to \\$5',
  ),
];

const demoOrderSteps = [
  OrderStatusStep(
    title: 'Order confirmed',
    subtitle: 'We have received your order',
    isComplete: true,
  ),
  OrderStatusStep(
    title: 'Packed',
    subtitle: 'Items packed at the store',
    isComplete: true,
  ),
  OrderStatusStep(
    title: 'Out for delivery',
    subtitle: 'Rider is on the way',
    isComplete: false,
  ),
  OrderStatusStep(
    title: 'Delivered',
    subtitle: 'Estimated 20 mins',
    isComplete: false,
  ),
];

const bannerGradients = [
  LinearGradient(
    colors: [Color(0xFF00B14F), Color(0xFF6FD98C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [Color(0xFFFFC107), Color(0xFFFFE082)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  LinearGradient(
    colors: [Color(0xFF00A3FF), Color(0xFF7EC8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
];

const promoChipColors = [
  AppColors.primary,
  AppColors.accent,
  AppColors.primaryDark,
];
