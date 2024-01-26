import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MOvieListShimmer extends StatelessWidget {
  const MOvieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return Shimmer.fromColors(
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
    );
  }
}
