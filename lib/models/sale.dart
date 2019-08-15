import 'package:json_annotation/json_annotation.dart';
import 'package:tiancell/models/item.dart';

part 'sale.g.dart';

@JsonSerializable()
class Sale {
  Sale();

  Sale.input(Item item, this.qty)
      : this.item = item,
        this.purchase = item.currentpurchase,
        this.price = item.price;

  Item item;
  num purchase;
  num price;
  num qty;

  get subtotal => this.price * this.qty;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
