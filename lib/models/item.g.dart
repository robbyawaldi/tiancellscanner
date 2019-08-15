// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..price = json['price'] as num
    ..stock = json['stock'] as num
    ..currentpurchase = json['currentpurchase'] as num;
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
      'currentpurchase': instance.currentpurchase
    };
