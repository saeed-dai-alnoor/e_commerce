import 'package:flutter/material.dart';

Widget buildListTile(
  String title,
  Widget icon, {
  required VoidCallback onTap,
  bool isLogout = false,
}) {
  return ListTile(
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    leading: icon,

    title: Row(
      children: [
        const SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.black)),
      ],
    ),
    trailing: const Icon(Icons.chevron_right, size: 32),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(vertical: 8),
  );
}
