import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DownloadinHomeView extends GetView {
  const DownloadinHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // مثال لمربع بحث رمادي
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.white,
              ),
              const SizedBox(height: 30),
              // عنوان "Categories"
              Container(height: 20, width: 150, color: Colors.white),
              const SizedBox(height: 20),
              // قائمة أفقيّة لعناصر الفئات (كدوائر)
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (_, _) => const SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              // عنوان "Best Selling"
              Container(height: 25, width: 120, color: Colors.white),
              const SizedBox(height: 12),
              // شبكة منتجات وهمية (grid placeholders)
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
