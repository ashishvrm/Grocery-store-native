import 'package:flutter/material.dart';
import '../../core/cart/cart_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/demo_data.dart';
import '../../core/theme/app_colors.dart';
import '../product/product_detail_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          const SizedBox(height: AppSpacing.md),
          _LocationHeader(),
          const SizedBox(height: AppSpacing.md),
          _SearchBar(),
          const SizedBox(height: AppSpacing.md),
          _PromoCarousel(),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: 'Shop by Category', action: 'View all'),
          const SizedBox(height: AppSpacing.sm),
          _CategoryChips(),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: 'Popular near you', action: 'See more'),
          const SizedBox(height: AppSpacing.sm),
          _ProductHighlights(
            products: demoProducts.take(4).toList(),
            onTap: (product) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              );
            },
            onAdd: (product) {
              CartScope.of(context).addProduct(product);
              _showAddedSnack(context, product.name);
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: 'Recommended', action: 'Refresh'),
          const SizedBox(height: AppSpacing.sm),
          _HorizontalProductRow(
            products: demoProducts,
            onTap: (product) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              );
            },
            onAdd: (product) {
              CartScope.of(context).addProduct(product);
              _showAddedSnack(context, product.name);
            },
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _LocationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.location_on_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deliver to',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Sai Park, Pune',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text('Change'),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {\n        Navigator.push(\n          context,\n          MaterialPageRoute(builder: (_) => const SearchScreen()),\n        );\n      },
      borderRadius: BorderRadius.circular(AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Search for groceries',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Icon(Icons.mic_none_rounded, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _PromoCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 260,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: bannerGradients[index % bannerGradients.length],
              borderRadius: BorderRadius.circular(AppSpacing.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fresh deals',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  'Save up to 25% on essentials',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Order now',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemCount: bannerGradients.length,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: () {}, child: Text(action)),
      ],
    );
  }
}

class _CategoryChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: demoCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final category = demoCategories[index];
          return Container(
            width: 110,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.lg),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(category.icon, color: promoChipColors[index % 3]),
                const SizedBox(height: 6),
                Text(
                  category.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProductHighlights extends StatelessWidget {
  const _ProductHighlights({
    required this.products,
    required this.onTap,
    required this.onAdd,
  });

  final List<ProductItem> products;
  final ValueChanged<ProductItem> onTap;
  final ValueChanged<ProductItem> onAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((product) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: ListTile(
            onTap: () => onTap(product),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.12),
              child: const Icon(Icons.local_mall_rounded,
                  color: AppColors.primary),
            ),
            title: Text(product.name),
            subtitle: Text('${product.unit} • ${product.category}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onAdd(product),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _HorizontalProductRow extends StatelessWidget {
  const _HorizontalProductRow({
    required this.products,
    required this.onTap,
    required this.onAdd,
  });

  final List<ProductItem> products;
  final ValueChanged<ProductItem> onTap;
  final ValueChanged<ProductItem> onAdd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final product = products[index];
          return InkWell(
            onTap: () => onTap(product),
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.lg),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                      child: Center(
                        child: Text(
                          product.imageLabel,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(product.name, maxLines: 1),
                  Text(
                    product.unit,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () => onAdd(product),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void _showAddedSnack(BuildContext context, String productName) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$productName added to cart'),
      duration: const Duration(seconds: 2),
    ),
  );
}
