import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_prj/presentation/components/extensions/build_context_extensions.dart';
import 'package:test_prj/presentation/components/text_field/app_text_field.dart';
import 'package:test_prj/presentation/components/text_field/show_password_button.dart';
import 'package:test_prj/presentation/home_screen/home_screen.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';
import 'package:test_prj/repository/local_storage_repository.dart';
import 'package:test_prj/repository/login_repository.dart';
import 'package:test_prj/resources/app_text_styles.dart';
import 'package:test_prj/validators/email_validator.dart';
import 'package:test_prj/validators/password_validator.dart';

import 'login_cubit.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
          localStorageRepository: context.read<LocalStorageRepository>(),
          loginRepository: context.read<LoginRepository>(),
          emailValidator: context.read<EmailValidator>(),
          passwordValidator: context.read<PasswordValidator>()),
      child: Builder(builder: (context) {
        return BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (context.read<LoginCubit>().state.isLogInComplete) {
                openHomeScreen(context);
              }
              if (context.read<LoginCubit>().state.isLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
            },
            child: buildScaffold(context));
      }),
    );
  }

  Widget buildScaffold(BuildContext context) {
    final bloc = context.watch<LoginCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(context.strings.loginScreenTitle,
                    style: AppTextStyles.h1Bold),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            const SliverToBoxAdapter(child: _LoginTextFields()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.strings.loginScreenCheckBox,
                      style: AppTextStyles.bodyL),
                  Checkbox(
                      value: bloc.state.isCheckboxValid,
                      onChanged: (value) {
                        bloc.changeCheckbox();
                      }),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: TextButton(
                onPressed: bloc.loginUser,
                child: Text(context.strings.loginScreenButton),
              ),
            ),
            // const SliverFillRemaining(),
          ],
        ),
      ),
    );
  }

  void openHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return const HomeScreen();
      }),
    );
  }
}

class _LoginTextFields extends StatelessWidget {
  const _LoginTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginCubit>();
    return Column(
      children: [
        const SizedBox(height: 36),
        AppTextField(
          controller: bloc.emailController,
          hintText: context.strings.loginScreenEmail,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.emailAddress,
          forceErrorBorder: !bloc.state.isEmailValid,
        ),
        const SizedBox(height: 20),
        AppTextField(
          controller: bloc.passwordController,
          obscureText: bloc.state.isPasswordObscureText,
          hintText: context.strings.loginScreenPassword,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.visiblePassword,
          forceErrorBorder: !bloc.state.isPasswordValid,
          suffixIcon: ShowPasswordButton(
            show: !bloc.state.isPasswordObscureText,
            onTap: bloc.changePasswordVisibility,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
