import 'package:flutter/material.dart';
import 'package:test_prj/domain/model/profile.dart';
import 'package:test_prj/presentation/components/extensions/build_context_extensions.dart';
import 'package:test_prj/resources/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileData profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        context.strings.profileScreenAppBapTitle,
        style: AppTextStyles.h1,
      )),
      body: Column(
        children: [
          _DataBox(
            title: context.strings.profileScreenGeneralInfoTitle,
            children: [
              _InfoRow(
                title: context.strings.profileScreenGeneralInfoName,
                data: profile.name,
              ),
              _InfoRow(
                title: context.strings.profileScreenGeneralInfoPhone,
                data: profile.phone,
              ),
              _InfoRow(
                title: context.strings.profileScreenGeneralInfoEmail,
                data: profile.email,
              ),
              _InfoRow(
                title: context.strings.profileScreenGeneralInfoUsername,
                data: profile.username,
              ),
              _InfoRow(
                title: context.strings.profileScreenGeneralInfoWebsite,
                data: profile.website,
              ),
            ],
          ),
          _DataBox(
            title: context.strings.profileScreenLocationInfoTitle,
            children: [
              _InfoRow(
                title: context.strings.profileScreenLocationInfoCity,
                data: profile.address.city,
              ),
              _InfoRow(
                title: context.strings.profileScreenLocationInfoAddress,
                data: profile.address.street,
              ),
              _InfoRow(
                title: context.strings.profileScreenLocationInfoSuite,
                data: profile.address.suite,
              ),
              _InfoRow(
                title: context.strings.profileScreenLocationInfoZip,
                data: profile.address.zipcode,
              ),
            ],
          ),
          _DataBox(
            title: context.strings.profileScreenCompanyInfoTitle,
            children: [
              _InfoRow(
                title: context.strings.profileScreenCompanyInfoName,
                data: profile.company.name,
              ),
              _InfoRow(
                title: context.strings.profileScreenCompanyInfoCatch,
                data: profile.company.catchPhrase,
              ),
              _InfoRow(
                title: context.strings.profileScreenCompanyInfoBS,
                data: profile.company.bs,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _DataBox extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DataBox({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyLBold,
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: children,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String data;

  const _InfoRow({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: AppTextStyles.bodyM,
          ),
        ),
        const SizedBox(),
        Expanded(
          child: Text(
            data,
            style: AppTextStyles.bodyMBold,
          ),
        ),
      ],
    );
  }
}
