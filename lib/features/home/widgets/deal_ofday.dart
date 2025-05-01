import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            l10n.dealOfDay,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Image.network(
          'https://m.media-amazon.com/images/I/51wGeVLkCAL._AC_SX522_.jpg',
          height: 235,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\$100',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "يوفي سيكيوريتي S380 هوم بيس 3 مركز أمان إيدج",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.specialDeal,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: List.generate(
              4,
              (index) => Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            l10n.seeAllDeals,
            style: TextStyle(
              color: Colors.cyan[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
