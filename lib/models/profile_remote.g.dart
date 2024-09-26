// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileRemote _$ProfileRemoteFromJson(Map<String, dynamic> json) =>
    ProfileRemote(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      address: ProfileAddressRemote.fromJson(
          json['address'] as Map<String, dynamic>),
      company: ProfileCompanyRemote.fromJson(
          json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileRemoteToJson(ProfileRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'website': instance.website,
      'address': instance.address,
      'company': instance.company,
    };

ProfileAddressRemote _$ProfileAddressRemoteFromJson(
        Map<String, dynamic> json) =>
    ProfileAddressRemote(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      geo: GeoRemote.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileAddressRemoteToJson(
        ProfileAddressRemote instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };

ProfileCompanyRemote _$ProfileCompanyRemoteFromJson(
        Map<String, dynamic> json) =>
    ProfileCompanyRemote(
      name: json['name'] as String,
      catchPhrase: json['catchPhrase'] as String,
      bs: json['bs'] as String,
    );

Map<String, dynamic> _$ProfileCompanyRemoteToJson(
        ProfileCompanyRemote instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };

GeoRemote _$GeoRemoteFromJson(Map<String, dynamic> json) => GeoRemote(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );

Map<String, dynamic> _$GeoRemoteToJson(GeoRemote instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
