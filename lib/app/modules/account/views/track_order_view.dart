import 'package:e_commerce_app/app/widgets/track_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class TrackOrderView extends GetView<AccountController> {
  const TrackOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.find<AccountController>().showTrackCardPage.value = false;
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: const Text('Track Order'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 20),
          Text(
            'Sept 23, 2018',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          TrackCard(
            title: 'OD - 424923192 - N',
            price: '\$233',
            imgUrl: 'assets/images/watch.png',
            buttonTitle: 'In Trnasit',
            buttonColor: Color(0xFFFFB900),
          ),
          const SizedBox(height: 40),
          Text(
            'Sept 18, 2018',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          TrackCard(
            title: 'OD - 424923192 - N',
            price: '\$243',
            imgUrl: 'assets/images/deoPlay.png',
            buttonTitle: 'Delevered',
            buttonColor: Color(0xFF00C569),
          ),
          const SizedBox(height: 20),
          TrackCard(
            title: 'OD - 424923192 - N',
            price: '\$433',
            imgUrl: 'assets/images/set.png',
            buttonTitle: 'Delevered',
            buttonColor: Color(0xFF00C569),
          ),
        ],
      ),
    );
  }
}
