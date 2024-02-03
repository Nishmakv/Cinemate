import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MOvieListShimmer extends StatelessWidget {
  final ThemeData theme;
  const MOvieListShimmer({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final Color baseColor = theme.brightness == Brightness.light
        ? const Color.fromARGB(31, 220, 217, 217)
        : const Color.fromARGB(31, 220, 217, 217);
    final Color highlightColor =
        theme.brightness == Brightness.light ? Colors.white : const Color.fromARGB(49, 220, 217, 217);
        final Color containerColor= theme.brightness == Brightness.light ? Colors.white : const Color.fromARGB(154, 220, 217, 217);
    return Padding(
      padding: EdgeInsets.only(left: w / 20),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: h / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                height: h / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                height: h / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
