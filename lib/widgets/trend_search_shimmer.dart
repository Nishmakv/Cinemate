import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrendingShimmer extends StatelessWidget {
  const TrendingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final Color baseColor = theme.brightness == Brightness.light
        ? const Color.fromARGB(31, 220, 217, 217)
        : const Color.fromARGB(31, 220, 217, 217);
    final Color highlightColor = theme.brightness == Brightness.light
        ? Colors.white
        : const Color.fromARGB(31, 220, 217, 217);
    final Color containerColor = theme.brightness == Brightness.light
        ? Colors.white
        : const Color.fromARGB(154, 220, 217, 217);
    return Padding(
      padding: EdgeInsets.only(top: h / 15, left: w / 20, right: w / 20),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: h / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: w / 25),
                Expanded(
                  child: Container(
                    height: h / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h / 50),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: h / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: w / 20),
                Expanded(
                  child: Container(
                    height: h / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h / 50),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: h / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: w / 20),
                Expanded(
                  child: Container(
                    height: h / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
