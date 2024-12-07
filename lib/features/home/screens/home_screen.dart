import 'package:flutter/material.dart';
import 'package:my_amazon_app/core/constants/global_var.dart';
import 'package:my_amazon_app/features/home/widgets/address_box.dart';
import 'package:my_amazon_app/features/home/widgets/carousel_images.dart';
import 'package:my_amazon_app/features/home/widgets/deal_ofday.dart';
import 'package:my_amazon_app/features/home/widgets/top_categories.dart';
import 'package:provider/provider.dart';
import 'package:my_amazon_app/shared/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_amazon_app/features/cart/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigateToCart() {
    Navigator.pushNamed(context, CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
                  height: 40,
                  margin: const EdgeInsets.only(left: 5),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      textAlign: languageProvider.isArabic
                          ? TextAlign.right
                          : TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.search,
                                color: Colors.black, size: 20),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic),
                          onPressed: () {},
                          splashRadius: 20,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: l10n.searchHint,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.language),
                      onPressed: () {
                        final provider = Provider.of<LanguageProvider>(
                          context,
                          listen: false,
                        );
                        provider.toggleLanguage();
                      },
                      splashRadius: 20,
                    ),
                    IconButton(
                      onPressed: navigateToCart,
                      icon: const Icon(Icons.shopping_cart_outlined),
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Directionality(
        textDirection:
            languageProvider.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: RefreshIndicator(
          onRefresh: () async {
            // TODO: Implement refresh logic
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                const TopCategories(),
                const SizedBox(height: 10),
                CarouselImages(),
                const SizedBox(height: 10),
                const DealOfDay(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
