import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(31, 220, 217, 217),
      highlightColor: Colors.white,
      child: Container(
        height: h / 35,
        width: w / 2,
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}
