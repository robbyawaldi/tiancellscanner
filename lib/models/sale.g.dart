// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return Sale()
    ..purchase = json['purchase'] as num
    ..price = json['price'] as num
    ..qty = json['qty'] as num;
}

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      'purchase': instance.purchase.toString(),
      'price': instance.price.toString(),
      'qty': instance.qty.toString()
    };
