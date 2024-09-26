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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildCard(
                title: context.strings.profileScreenGeneralInfoTitle,
                children: [
                  buildRow(
                    title: context.strings.profileScreenGeneralInfoName,
                    data: profile.name,
                  ),
                  buildRow(
                    title: context.strings.profileScreenGeneralInfoPhone,
                    data: profile.phone,
                  ),
                  buildRow(
                    title: context.strings.profileScreenGeneralInfoEmail,
                    data: profile.email,
                  ),
                  buildRow(
                    title: context.strings.profileScreenGeneralInfoUsername,
                    data: profile.username,
                  ),
                  buildRow(
                    title: context.strings.profileScreenGeneralInfoWebsite,
                    data: profile.website,
                  ),
                ]),
            buildCard(
              title: context.strings.profileScreenLocationInfoTitle,
              children: [
                buildRow(
                  title: context.strings.profileScreenLocationInfoCity,
                  data: profile.address.city,
                ),
                buildRow(
                  title: context.strings.profileScreenLocationInfoAddress,
                  data: profile.address.street,
                ),
                buildRow(
                  title: context.strings.profileScreenLocationInfoSuite,
                  data: profile.address.suite,
                ),
                buildRow(
                  title: context.strings.profileScreenLocationInfoZip,
                  data: profile.address.zipcode,
                ),
              ],
            ),
            buildCard(
              title: context.strings.profileScreenCompanyInfoTitle,
              children: [
                buildRow(
                  title: context.strings.profileScreenCompanyInfoName,
                  data: profile.company.name,
                ),
                buildRow(
                  title: context.strings.profileScreenCompanyInfoCatch,
                  data: profile.company.catchPhrase,
                ),
                buildRow(
                  title: context.strings.profileScreenCompanyInfoBS,
                  data: profile.company.bs,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
      ),
    );
  }

  Widget buildRow({
    required String title,
    required String data,
  }) {
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
