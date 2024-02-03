import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final ThemeData theme = Theme.of(context);
    final Color baseColor = theme.brightness == Brightness.light
        ? const Color.fromARGB(31, 220, 217, 217)
        : const Color.fromARGB(31, 220, 217, 217);
    final Color highlightColor = theme.brightness == Brightness.light
        ? Colors.white
        : const Color.fromARGB(31, 220, 217, 217);
    final Color containerColor = theme.brightness == Brightness.light
        ? Colors.white
        : const Color.fromARGB(154, 220, 217, 217);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: h / 35,
        width: w / 2,
        decoration: BoxDecoration(color: containerColor),
      ),
    );
  }
}
