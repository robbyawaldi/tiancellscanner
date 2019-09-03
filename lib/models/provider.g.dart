// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Provider _$ProviderFromJson(Map<String, dynamic> json) {
  return Provider()
    ..name = json['name'] as String
    ..nominals = (json['nominals'] as List)
        ?.map((e) =>
            e == null ? null : Nominal.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProviderToJson(Provider instance) =>
    <String, dynamic>{'name': instance.name, 'nominals': instance.nominals};
