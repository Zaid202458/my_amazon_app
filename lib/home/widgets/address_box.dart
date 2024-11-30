import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
/// ودجت مربع العنوان
/// يعرض عنوان التوصيل الحالي للمستخدم مع إمكانية تغييره
class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: GlobalVar.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, size: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                l10n.deliveryAddress,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5, top: 2, right: 10),
            child: Icon(Icons.arrow_drop_down_outlined, size: 18),
          ),
        ],
      ),
    );
  }
}
