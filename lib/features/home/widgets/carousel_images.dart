import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../core/constants/global_var.dart';

/// ودجت عرض شرائح الصور
/// يعرض صور المنتجات والعروض في شكل شرائح متحركة
/// مع خاصية التنقل التلقائي بين الصور
class CarouselImages extends StatelessWidget {
  const CarouselImages({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: GlobalVar.carouselImages.length,
      itemBuilder: (context, index, realIndex) {
        return Image.network(
          GlobalVar.carouselImages[index],
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.error_outline, size: 50),
              ),
            );
          },
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
