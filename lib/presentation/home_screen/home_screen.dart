import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/models/profile.dart';
import 'package:test_prj/presentation/components/extensions/build_context_extensions.dart';
import 'package:test_prj/presentation/home_screen/home_bloc.dart';
import 'package:test_prj/presentation/home_screen/home_state.dart';
import 'package:test_prj/presentation/home_screen/profile_screen/profile_screen.dart';
import 'package:test_prj/presentation/login_screens/login_screen.dart';
import 'package:test_prj/repository/local_storage_repository.dart';
import 'package:test_prj/repository/profile_data_repository.dart';
import 'package:test_prj/resources/app_colors.dart';
import 'package:test_prj/resources/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        profileDataRepository: context.read<ProfileDataRepository>(),
        localStorageRepository: context.read<LocalStorageRepository>(),
      ),
      child: Builder(builder: (context) {
        return BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.hasRemovedToken) {
                _logOut(context);
              }
              if (state.exception) {
                _showSnackBar(context);
              }
            },
            child: buildScaffold(context));
      }),
    );
  }

  Widget buildScaffold(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.strings.homeScreenAppBapTitle,
          style: AppTextStyles.h1,
        ),
        actions: [
          _ScreenAction(
            onPressed: () {
              bloc.add(LogOutEvent());
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(GetDataEvent());
        },
        child: ListView.builder(
          itemCount: bloc.state.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                bloc.state.data[index].name,
                style: AppTextStyles.bodyLBold,
              ),
              subtitle: Text(
                bloc.state.data[index].phone,
                style: AppTextStyles.bodyM,
              ),
              leading: const Icon(
                Icons.person,
                size: 32,
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                size: 32,
              ),
              onTap: () {
                _openPersonalDataScreen(context,
                    profile: bloc.state.data[index]);
              },
            );
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.strings.unexpectedError),
      ),
    );
  }

  void _openPersonalDataScreen(
    BuildContext context, {
    required ProfileData profile,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return ProfileScreen(profile: profile);
      }),
    );
  }

  void _logOut(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return const LogInScreen();
      }),
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
