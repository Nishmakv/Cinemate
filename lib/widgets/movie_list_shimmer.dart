import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MOvieListShimmer extends StatelessWidget {
  const MOvieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red,
      // const Color.fromARGB(31, 220, 217, 217),
      highlightColor: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(height: 160),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(height: 160),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(height: 160),
          ),
        ],
      ),
    );
  }
}
