import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class ProfileData with _$ProfileData {
  const ProfileData._();

  const factory ProfileData({
    required int id,
    required String name,
    required String username,
    required String email,
    required ProfileAddress address,
    required String phone,
    required String website,
    required ProfileCompany company,
  }) = _ProfileData;
}

@freezed
class ProfileCompany with _$ProfileCompany {
  const ProfileCompany._();

  const factory ProfileCompany({
    required String name,
    required String catchPhrase,
    required String bs,
  }) = _ProfileCompany;
}

@freezed
class ProfileAddress with _$ProfileAddress {
  const ProfileAddress._();

  const factory ProfileAddress({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
  }) = _ProfileAddress;
}

@freezed
class Geo with _$Geo {
  const Geo._();

  const factory Geo({
    required String lat,
    required String lng,
  }) = _Geo;
}
