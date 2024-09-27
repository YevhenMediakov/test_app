import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
          color: Colors.transparent, shape: BoxShape.circle),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(36, 36, 36, 36),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
