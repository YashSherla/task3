import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  final Duration autoPlayInterval;
  final List<Widget> items;
  final double dotSize;
  final double activeDotSize;

  const ImageCarousel({
    super.key,
    this.autoPlayInterval = const Duration(seconds: 4),
    required this.items,
    this.dotSize = 8.0,
    this.activeDotSize = 12.0,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) {
            return widget.items[index];
          },
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            autoPlayInterval: widget.autoPlayInterval,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              width: _currentIndex == index
                  ? widget.activeDotSize
                  : widget.dotSize,
              height: _currentIndex == index
                  ? widget.activeDotSize
                  : widget.dotSize,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
