import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrendingShimmer extends StatelessWidget {
  const TrendingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(31, 220, 217, 217),
      highlightColor: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: h / 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
               SizedBox(width: w/10),
               SizedBox(height: h/10),
              Expanded(
                child: Container(
                  height: h / 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: w/10),
               SizedBox(height: h/10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: h / 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(width: w/10),
               SizedBox(height: h/10),
              Expanded(
                child: Container(
                  height: h / 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: w/10),
               SizedBox(height: h/10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: h / 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
               SizedBox(width: w/10),
               SizedBox(height: h/10),
              Expanded(
                child: Container(
                  height: h / 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
