import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants/global_var.dart';

class Category {
  final String title;
  final IconData icon;

  const Category({required this.title, required this.icon});
}

/// ودجت الفئات الرئيسية
/// يعرض قائمة أفقية للفئات الرئيسية مثل الجوالات والإلكترونيات والأزياء
/// مع إمكانية التنقل بينها بسهولة
class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categoryTitles = [
      l10n.categoryHome,
      l10n.categoryBeauty,
      l10n.categoryElectronics,
      l10n.categoryFashion,
      l10n.categoryGrocery,
      l10n.categoryMobiles,
      l10n.categoryKitchen,
      l10n.categorySports,
      l10n.categoryHealth,
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVar.categoriesImages.length,
        itemExtent: 100,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle category tap
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVar.categoriesImages[index]['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  categoryTitles[index],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
