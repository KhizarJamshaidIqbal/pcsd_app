import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pcsd_app/constants/app_size.dart';
import 'package:pcsd_app/constants/colors.dart';
class VideoScreenShimerEffect extends StatelessWidget {
  const VideoScreenShimerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
              baseColor: globalColors.WhiteColor.withOpacity(0.5),
              highlightColor: globalColors.WhiteColor.withOpacity(0.3),
              direction: ShimmerDirection.ltr,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: globalColors.primaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          15.w,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: globalColors.WhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          10.w,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: globalColors.WhiteColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              5.h,
                              Container(
                                height: 20,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: globalColors.WhiteColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
  }
}