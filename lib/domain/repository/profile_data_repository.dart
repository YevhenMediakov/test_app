import 'package:dio/dio.dart';
import 'package:test_prj/data/model/profile_remote.dart';
import 'package:test_prj/domain/model/profile.dart';

interface class ProfileDataRepository {
  final dio = Dio();

  Future<List<ProfileData>> getData() async {
    try {
      final response =
          await dio.get("https://jsonplaceholder.typicode.com/users");
      return (response.data as List<dynamic>)
          .map((json) => ProfileRemote.fromJson(json).toData())
          .toList();
    } catch (exception) {
      return [];
    }
  }
}
