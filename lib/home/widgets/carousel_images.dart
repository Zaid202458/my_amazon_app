import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
/// ودجت عرض شرائح الصور
/// يعرض صور المنتجات والعروض في شكل شرائح متحركة
/// مع خاصية التنقل التلقائي بين الصور
class CarouselImages extends StatelessWidget {
  CarouselImages({super.key});

  final List<Widget> carouselItems = List.generate(
    3,
    (index) => Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: const Center(
        child: Icon(Icons.image, size: 50),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: carouselItems,
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
        autoPlay: true,
      ),
    );
  }
}
