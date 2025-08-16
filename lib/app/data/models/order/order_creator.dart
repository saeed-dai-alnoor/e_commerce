// To parse this JSON data, do
//
//     final orderCreator = orderCreatorFromJson(jsonString);

import 'dart:convert';

OrderCreator orderCreatorFromJson(String str) =>
    OrderCreator.fromJson(json.decode(str));

String orderCreatorToJson(OrderCreator data) => json.encode(data.toJson());

class OrderCreator {
  List<Item> items;
  ShippingAddress shippingAddress;

  OrderCreator({required this.items, required this.shippingAddress});

  factory OrderCreator.fromJson(Map<String, dynamic> json) => OrderCreator(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "shippingAddress": shippingAddress.toJson(),
  };
}

class Item {
  String productId;
  int quantity;
  int priceAtPurchase;

  Item({
    required this.productId,
    required this.quantity,
    required this.priceAtPurchase,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: json["productId"],
    quantity: json["quantity"],
    priceAtPurchase: json["priceAtPurchase"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
    "priceAtPurchase": priceAtPurchase,
  };
}

class ShippingAddress {
  String street1;
  String city;
  String state;
  String country;

  ShippingAddress({
    required this.street1,
    required this.city,
    required this.state,
    required this.country,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        street1: json["street1"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
    "street1": street1,
    "city": city,
    "state": state,
    "country": country,
  };
}
