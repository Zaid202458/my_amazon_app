import 'package:flutter/material.dart';
import 'package:my_amazon_app/widgets/account_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainButtons extends StatefulWidget {
  const MainButtons({super.key});

  @override
  State<MainButtons> createState() => _MainButtonsState();
}

class _MainButtonsState extends State<MainButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            AccountButtons(
              txt: AppLocalizations.of(context)!.yourOrders,
              onClick: () {},
            ),
            AccountButtons(
              txt: AppLocalizations.of(context)!.turnSeller,
              onClick: () {},
            ),
            AccountButtons(
              txt: AppLocalizations.of(context)!.yourWishList,
              onClick: () {},
            ),
            AccountButtons(
              txt: AppLocalizations.of(context)!.logOut,
              onClick: () {},
            ),
          ],
        ),
      ],
    );
  }
}