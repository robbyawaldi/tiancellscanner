// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  return Service()
    ..brand = json['brand'] as String
    ..type = json['type'] as String
    ..desc = json['desc'] as String
    ..cost = json['cost'] as num
    ..price = json['price'] as num;
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'brand': instance.brand,
      'type': instance.type,
      'desc': instance.desc,
      'cost': instance.cost.toString(),
      'price': instance.price.toString()
    };
