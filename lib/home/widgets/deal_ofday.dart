import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
/// ودجت صفقة اليوم
/// يعرض المنتج المميز كصفقة اليوم مع تفاصيل السعر والخصم
/// ويتضمن صور إضافية للمنتج وزر لعرض جميع العروض
class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: Text(
            l10n.dealOfDay,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: 235,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_offer, size: 50),
                SizedBox(height: 10),
                Text(
                  'Daily Deals Coming Soon!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\$100',
                style:  TextStyle(fontSize: 18),
              ),
              Text(
                l10n.specialDeal,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 40),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            l10n.seeAllDeals,
            style:  TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
