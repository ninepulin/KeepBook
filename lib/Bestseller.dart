import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BestSaleCarousel extends StatelessWidget {
  final List<String> imgList;
  final String bestSaleText;

  const BestSaleCarousel({
    Key? key,
    required this.imgList,
    required this.bestSaleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Text(bestSaleText, style: Theme.of(context).textTheme.titleLarge),
        ),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            aspectRatio: 1.9,
          ),
          items: imgList
              .map((item) => Image.network(item, fit: BoxFit.cover, width: 150))
              .toList(),
        ),
      ],
    );
  }
}
