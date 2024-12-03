import 'package:flutter/material.dart';
import 'package:my_amazon_app/constants/global_var.dart';
import 'package:my_amazon_app/features/profile/screens/profile_screen.dart';
import 'package:my_amazon_app/home/widgets/address_box.dart';
import 'package:my_amazon_app/home/widgets/carousel_images.dart';
import 'package:my_amazon_app/home/widgets/deal_ofday.dart';
import 'package:my_amazon_app/home/widgets/top_categories.dart';
import 'package:provider/provider.dart';
import 'package:my_amazon_app/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_amazon_app/features/cart/screens/cart_screen.dart';

/// شاشة الصفحة الرئيسية لتطبيق أمازون
/// تحتوي على العناصر التالية:
/// - شريط البحث في الأعلى مع أيقونة البحث الصوتي
/// - صندوق العنوان لعرض موقع التوصيل
/// - الفئات الرئيسية للتسوق
/// - عرض شريحة الصور للمنتجات المميزة
/// - عروض اليوم للمنتجات المخفضة
/// - شريط تنقل سفلي للتنقل بين الصفحات الرئيسية
class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// حالة شاشة الصفحة الرئيسية
/// تدير:
/// - التنقل بين صفحات التطبيق
/// - عرض المنتجات والفئات
/// - التفاعل مع شريط البحث
/// - عرض العناوين والإعدادات
class _HomeScreenState extends State<HomeScreen> {
  /// مؤشر الصفحة المحددة في شريط التنقل السفلي
  /// 0: الصفحة الرئيسية
  /// 1: الملف الشخصي
  /// 2: سلة التسوق
  int _selectedIndex = 0;

  /// الانتقال إلى صفحة سلة التسوق
  /// يستخدم عند النقر على أيقونة السلة
  void navigateToCart() {
    Navigator.pushNamed(context, CartScreen.routeName);
  }

  void navigateToProfile() {
    Navigator.pushNamed(context, ProfileScreen.routeName);
  }

  /// معالجة النقر على عناصر شريط التنقل السفلي
  /// [index] رقم العنصر المحدد في شريط التنقل
  /// 0: الرئيسية
  /// 1: الملف الشخصي
  /// 2: السلة
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // التنقل إلى الشاشة المناسبة
    switch (index) {
      case 1: // Profile
        navigateToProfile();
        break;
      case 2: // Cart
        navigateToCart();
        break;
    }
  }

  /// بناء واجهة الصفحة الرئيسية
  /// يتكون من:
  /// - شريط علوي يحتوي على حقل البحث وأيقونة البحث الصوتي
  /// - قسم رئيسي يعرض العنوان والفئات والعروض
  /// - شريط تنقل سفلي للتنقل بين الصفحات
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
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
                                color: Colors.black, size: 23),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.mic),
                          onPressed: () {},
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
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    // زر تغيير اللغة
                    IconButton(
                      icon: const Icon(Icons.language),
                      onPressed: () {
                        final provider = Provider.of<LanguageProvider>(
                          context,
                          listen: false,
                        );
                        provider.toggleLanguage();
                      },
                    ),
                    // زر السلة
                    IconButton(
                      onPressed: navigateToCart,
                      icon: const Icon(Icons.shopping_cart_outlined),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBox(),
              const SizedBox(height: 10),
              const TopCategories(),
              const SizedBox(height: 10),
              CarouselImages(),
              const SizedBox(height: 10),
              const DealOfDay(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            activeIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            activeIcon: const Icon(Icons.shopping_cart),
            label: l10n.cart,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalVar.selectedNavBarColor,
        unselectedItemColor: GlobalVar.unselectedNavBarColor,
        backgroundColor: GlobalVar.backgroundColor,
        iconSize: 28,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        elevation: 5,
      ),
    );
  }
}
