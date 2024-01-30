import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: w / 20),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(31, 220, 217, 217),
            highlightColor: Colors.white,
            child: Container(
              width: double.infinity,
              height: h / 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(31, 220, 217, 217),
            highlightColor: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: h / 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      color: Colors.white,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
