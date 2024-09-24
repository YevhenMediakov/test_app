import 'package:flutter/material.dart';

import 'package:test_prj/resources/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
    return Scaffold(
      appBar: AppBar(
        actions: [_ScreenAction(onPressed: (){},)],
      ),
      body: ListView()
    );
  }
}

class _ScreenAction extends StatelessWidget {
  final VoidCallback onPressed;

  const _ScreenAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.logout_outlined, size: 24, color: AppColors.red)),
        const Spacer(),
      ],
    );
  }
}
