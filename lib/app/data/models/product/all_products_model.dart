// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<AllProductsModel> allProductsModelFromJson(String str) =>
    List<AllProductsModel>.from(
      json.decode(str).map((x) => AllProductsModel.fromJson(x)),
    );

String allProductsModelToJson(List<AllProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllProductsModel {
  String id;
  String name;
  String description;
  int price;
  String category;
  String size;
  // Color color;
  String color;
  String imgUrl;
  bool isBestSelling;
  bool is_new;
  DateTime date;
  int v;
  int quantity; // أضف هذا

  AllProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.size,
    required this.color,
    required this.imgUrl,
    required this.isBestSelling,
    required this.is_new,
    required this.date,
    required this.v,
    required this.quantity, // القيمة الافتراضية 1
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      AllProductsModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        size: json["size"],
        color: json["color"],
        imgUrl: json["imgUrl"],
        isBestSelling: json["isBestSelling"],
        is_new: json["is_new"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
        quantity: json["quantity"], // ← الحل هنا
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "price": price,
    "category": category,
    "size": size,
    "color": color,
    "imgUrl": imgUrl,
    "isBestSelling": isBestSelling,
    "is_new": is_new,
    "date": date.toIso8601String(),
    "__v": v,
    "quantity": quantity, // لو مش عايز تحفظه في DB ممكن تحذفه
  };
}
