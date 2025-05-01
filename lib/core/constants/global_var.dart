import 'package:flutter/material.dart';

String uri =
    'http://10.0.2.2:3000'; // 10.0.2.2 is the special IP for localhost when using Android emulator

class GlobalVar {
  static const appBarColor = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  static const secondaryColor = Color.fromARGB(255, 29, 201, 192);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const List<String> carouselImages = [
    'https://m.media-amazon.com/images/G/40/Electronics/Store/kamja/L2/Laptops/New/Nav_03_4star._SS400_QL85_.jpg',
    'https://m.media-amazon.com/images/G/40/Electronics/Store/kamja/L2/Electronics/Rotator/rotator_tvs._SS400_QL85_.jpg',
    'https://m.media-amazon.com/images/G/40/Electronics/Store/kamja/L2/Electronics/Rotator/rotator_videogames._SS400_QL85_.jpg',
    'https://m.media-amazon.com/images/G/40/Electronics/Store/kamja/L2/Electronics/Rotator/rotator_dvg_sa_ar._SS400_QL85_.jpg',
  ];

  static const List<Map<String, String>> categoriesImages = [
    {
      'title': 'Home ',
      'image': 'assets/images/home.jpg',
    },
    {
      'title': 'Beauty',
      'image': 'assets/images/beauty.jpg',
    },
    {
      'title': 'Electronics',
      'image': 'assets/images/electronics.jpg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpg',
    },
    {
      'title': 'Grocery',
      'image': 'assets/images/grocery.jpg',
    },
    {
      'title': 'Mobile',
      'image': 'assets/images/mobile.jpg',
    },
    {
      'title': 'Kitchen',
      'image': 'assets/images/kitchen.jpg',
    },
    {
      'title': 'Sports',
      'image': 'assets/images/sports.jpg',
    },
    {
      'title': 'Health',
      'image': 'assets/images/health.jpg',
    },
  ];
}
