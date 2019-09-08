// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nominal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nominal _$NominalFromJson(Map<String, dynamic> json) {
  return Nominal()
    ..id = json['id'] as num
    ..provider = json['provider'] as num
    ..name = json['name'] as String
    ..cost = json['cost'] as num
    ..price = json['price'] as num;
}

Map<String, dynamic> _$NominalToJson(Nominal instance) => <String, dynamic>{
      'id': instance.id,
      'provider': instance.provider,
      'name': instance.name,
      'cost': instance.cost,
      'price': instance.price
    };
