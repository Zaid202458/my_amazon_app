import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// ودجت الفئات الرئيسية
/// يعرض قائمة أفقية للفئات الرئيسية مثل الجوالات والإلكترونيات والأزياء
/// مع إمكانية التنقل بينها بسهولة
class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = [
      {'title': l10n.categoryMobiles},
      {'title': l10n.categoryElectronics},
      {'title': l10n.categoryFashion},
      {'title': l10n.categoryHome},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
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
                  child: const Icon(Icons.category, size: 30),
                ),
                const SizedBox(height: 5),
                Text(
                  categories[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
