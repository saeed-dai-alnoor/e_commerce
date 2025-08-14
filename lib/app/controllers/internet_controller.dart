// ignore_for_file: use_build_context_synchronously

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';

class InternetController extends GetxController {
  var isConnected = true.obs;

  void _showBanner(
    BuildContext context,
    String message,
    Color color, {
    bool showRetry = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          content: Text(message, style: TextStyle(color: Colors.white)),
          backgroundColor: color,
          actions: showRetry
              ? [
                  TextButton(
                    onPressed: () async {
                      bool hasInternet = await InternetConnectionChecker
                          .instance
                          .hasConnection;
                      if (hasInternet) {
                        isConnected.value = true;
                        _showBanner(
                          context,
                          "Internet Restored",
                          Color(0xFF00C569),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          ScaffoldMessenger.of(
                            context,
                          ).hideCurrentMaterialBanner();
                        });
                      }
                    },
                    child: SizedBox.shrink(),
                  ),
                ]
              : [SizedBox.shrink()], // عنصر افتراضي لتجنب الخطأ
        ),
      );
  }

  void startMonitoring(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((_) async {
      bool hasInternet = await InternetConnectionChecker.instance.hasConnection;

      if (hasInternet != isConnected.value) {
        isConnected.value = hasInternet;

        if (!hasInternet) {
          _showBanner(context, "No Internet Connection", Colors.red);
        } else {
          _showBanner(context, "Internet Restored", Color(0xFF00C569));
          Future.delayed(Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
        }
      }
    });
  }
}
