import 'package:flutter/material.dart';

class TrackCard extends StatelessWidget {
  final String title;
  final String price;
  final String imgUrl;
  final String buttonTitle;
  final Color buttonColor;

  const TrackCard({
    super.key,
    required this.title,
    required this.price,
    required this.imgUrl,
    required this.buttonTitle,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                price,
                style: TextStyle(fontSize: 16, color: Color(0xFF00C569)),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      2,
                    ), // <-- هنا تتحكم في الاستدارة
                  ),
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 11),
                ),
                onPressed: () {},
                child: Text(buttonTitle, style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(width: 23),
          Image.asset(imgUrl, width: 105, height: 105, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
