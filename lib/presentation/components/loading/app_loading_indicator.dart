import 'dart:async';


import 'package:flutter/material.dart';
import 'package:test_prj/resources/app_colors.dart';

class AppLoadingIndicator extends StatefulWidget {
  const AppLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLoadingIndicator> createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.blue,
            width: 1,
          ),
          shape: BoxShape.circle
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(36, 0, 36, 36),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
