// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return Sale()
    ..item = json['item'] == null
        ? null
        : Item.fromJson(json['item'] as Map<String, dynamic>)
    ..qty = json['qty'] as num;
}

Map<String, dynamic> _$SaleToJson(Sale instance) =>
    <String, dynamic>{'item': instance.item, 'qty': instance.qty};
