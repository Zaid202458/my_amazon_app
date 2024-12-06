import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_amazon_app/widgets/main_buttons.dart';
import 'package:my_amazon_app/widgets/orders.dart';
// import 'package:provider/provider.dart';
// import 'package:my_amazon_app/providers/user_provider.dart';
import '../../../widgets/appbar_text.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVar.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon-logo.png',
                    height: 35,
                    width: 100,
                    color: Colors.black,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_on_outlined),
                      onPressed: () {
                        // TODO: Implement notifications
                      },
                      splashRadius: 20,
                    ),
                    IconButton(
                      icon: const Icon(Icons.search_rounded),
                      onPressed: () {
                        // TODO: Implement search
                      },
                      splashRadius: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
            ),
            child: const Column(
              children: [
                AppBarText(),
                SizedBox(height: 20),
                MainButtons(),
                SizedBox(height: 20),
                Orders(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
