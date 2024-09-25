import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:test_prj/data/model/profile_remote.dart';
import 'package:test_prj/domain/model/profile.dart';

abstract class ProfileDataRepository {
  Future<List<ProfileData>> getData();


}

class ProfileDataRepositoryImpl implements ProfileDataRepository {


  @override
  Future<List<ProfileData>> getData() async {
    String data = await rootBundle.loadString('assets/data.json');
    List<dynamic> decodedData = jsonDecode(data);
    return decodedData.map((e)=> ProfilerRemote.fromJson(e).toData).toList();
  }

}