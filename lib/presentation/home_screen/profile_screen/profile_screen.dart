import 'package:flutter/material.dart';
import 'package:test_prj/domain/model/profile.dart';
import 'package:test_prj/resources/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileData data;

  const ProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _DataRow(
            name: '',
            data: '',
          )
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final String name;
  final String data;

  const _DataRow({super.key, required this.name, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: AppTextStyles.bodyM,
        ),
        const Spacer(),
        Text(
          data,
          style: AppTextStyles.bodyM,
        )
      ],
    );
  }
}
