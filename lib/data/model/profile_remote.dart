import 'package:json_annotation/json_annotation.dart';
import 'package:test_prj/domain/model/profile.dart';

part 'profile_remote.g.dart';

@JsonSerializable()
class ProfilerRemote {
  @JsonKey()
  final int id;
  @JsonKey()
  final String name;
  @JsonKey()
  final String username;
  @JsonKey()
  final String email;
  @JsonKey()
  final String phone;
  @JsonKey()
  final String website;
  @JsonKey()
  final ProfileAddressRemote address;
  @JsonKey()
  final ProfileCompanyRemote company;

  ProfilerRemote({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory ProfilerRemote.fromJson(Map<String, dynamic> json) =>
      _$ProfilerRemoteFromJson(json);

  ProfileData get toData => ProfileData(
        id: id,
        name: name,
        username: username,
        email: email,
        address: address.toData,
        phone: phone,
        website: website,
        company: company.toData,
      );
}

@JsonSerializable()
class ProfileAddressRemote {
  @JsonKey()
  final String street;
  @JsonKey()
  final String suite;
  @JsonKey()
  final String city;
  @JsonKey()
  final String zipcode;
  @JsonKey()
  final GeoRemote geo;

  ProfileAddressRemote({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory ProfileAddressRemote.fromJson(Map<String, dynamic> json) =>
      _$ProfileAddressRemoteFromJson(json);

  ProfileAddress get toData => ProfileAddress(
        street: street,
        suite: suite,
        city: city,
        zipcode: zipcode,
      );
}

@JsonSerializable()
class ProfileCompanyRemote {
  @JsonKey()
  final String name;
  @JsonKey()
  final String catchPhrase;
  @JsonKey()
  final String bs;

  ProfileCompanyRemote({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory ProfileCompanyRemote.fromJson(Map<String, dynamic> json) =>
      _$ProfileCompanyRemoteFromJson(json);

  ProfileCompany get toData => ProfileCompany(
        name: name,
        catchPhrase: catchPhrase,
        bs: bs,
      );
}

@JsonSerializable()
class GeoRemote {
  @JsonKey()
  final String lat;
  @JsonKey()
  final String lng;

  GeoRemote({
    required this.lat,
    required this.lng,
  });

  factory GeoRemote.fromJson(Map<String, dynamic> json) =>
      _$GeoRemoteFromJson(json);

  Geo get toData => Geo(
        lat: lat,
        lng: lng,
      );
}
