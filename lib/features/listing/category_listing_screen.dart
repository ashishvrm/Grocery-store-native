import 'package:flutter/material.dart';
import '../../core/cart/cart_scope.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/demo_data.dart';
import '../../core/theme/app_colors.dart';
import '../product/product_detail_screen.dart';

class CategoryListingScreen extends StatefulWidget {
  const CategoryListingScreen({
    super.key,
    required this.category,
  });

  final CategoryItem category;

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen> {
  String _sortBy = 'Popular';
  bool _onlyDiscounted = false;

  List<ProductItem> get _filteredProducts {
    final products = demoProducts
        .where((product) => product.category == widget.category.title)
        .toList();

    final filtered = _onlyDiscounted
        ? products.where((product) => product.discountLabel != null).toList()
        : products;

    switch (_sortBy) {
      case 'Price: Low to High':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: _openFilters,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(widget.category.icon, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.category.title,
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('${products.length} items',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _ActiveFilters(
            sortBy: _sortBy,
            onlyDiscounted: _onlyDiscounted,
          ),
          const SizedBox(height: AppSpacing.lg),
          ...products.map(
            (product) => Card(
              child: ListTile(
                leading: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.shopping_basket_rounded,
                      color: AppColors.primary),
                ),
                title: Text(product.name),
                subtitle: Text(product.unit),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$${product.price.toStringAsFixed(2)}'),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        CartScope.of(context).addProduct(product);
                        _showAddedSnack(context, product.name);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openFilters() async {
    final result = await showModalBottomSheet<_FilterResult>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return _FilterSheet(
          initialSort: _sortBy,
          initialDiscounted: _onlyDiscounted,
        );
      },
    );

    if (result == null) return;
    setState(() {
      _sortBy = result.sortBy;
      _onlyDiscounted = result.onlyDiscounted;
    });
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

class _ActiveFilters extends StatelessWidget {
  const _ActiveFilters({
    required this.sortBy,
    required this.onlyDiscounted,
  });

  final String sortBy;
  final bool onlyDiscounted;

  @override
  Widget build(BuildContext context) {
    final filters = <String>[
      sortBy,
      if (onlyDiscounted) 'Discounted',
    ];
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: filters
          .map(
            (filter) => Chip(
              label: Text(filter),
              backgroundColor: AppColors.primary.withOpacity(0.12),
            ),
          )
          .toList(),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({
    required this.initialSort,
    required this.initialDiscounted,
  });

  final String initialSort;
  final bool initialDiscounted;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String _sortBy;
  late bool _onlyDiscounted;

  @override
  void initState() {
    super.initState();
    _sortBy = widget.initialSort;
    _onlyDiscounted = widget.initialDiscounted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filters', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              'Popular',
              'Price: Low to High',
              'Price: High to Low',
              'Rating',
            ]
                .map(
                  (sort) => ChoiceChip(
                    label: Text(sort),
                    selected: _sortBy == sort,
                    onSelected: (_) => setState(() => _sortBy = sort),
                    selectedColor: AppColors.primary.withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: _sortBy == sort
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          SwitchListTile(
            value: _onlyDiscounted,
            onChanged: (value) => setState(() => _onlyDiscounted = value),
            title: const Text('Show discounted items only'),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _sortBy = 'Popular';
                      _onlyDiscounted = false;
                    });
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      _FilterResult(
                        sortBy: _sortBy,
                        onlyDiscounted: _onlyDiscounted,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterResult {
  const _FilterResult({required this.sortBy, required this.onlyDiscounted});

  final String sortBy;
  final bool onlyDiscounted;
}
