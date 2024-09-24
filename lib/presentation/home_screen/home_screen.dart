import 'dart:math';

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

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // todo add text
        title: Text("TITLE"),
        actions: [
          _ScreenAction(
            onPressed: () {
              print("pressed");
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(index.toString()),
            );
          },
        ),
      ),
    );
  }
}

class _ScreenAction extends StatelessWidget {
  final VoidCallback onPressed;

  const _ScreenAction({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.logout_outlined,
                size: 24, color: AppColors.red)),
      ],
    );
  }
}
