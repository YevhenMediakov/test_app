import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_prj/presentation/components/extensions/build_context_extensions.dart';
import 'package:test_prj/presentation/components/loading/app_loading_overlay.dart';
import 'package:test_prj/presentation/components/text_field/app_text_field.dart';
import 'package:test_prj/presentation/components/text_field/show_password_button.dart';
import 'package:test_prj/presentation/home_screen/home_screen.dart';
import 'package:test_prj/presentation/login_screens/login_bloc.dart';
import 'package:test_prj/presentation/login_screens/login_state.dart';
import 'package:test_prj/repository/local_storage_repository.dart';
import 'package:test_prj/repository/login_repository.dart';
import 'package:test_prj/resources/app_colors.dart';
import 'package:test_prj/resources/app_text_styles.dart';
import 'package:test_prj/validators/email_validator.dart';
import 'package:test_prj/validators/password_validator.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          localStorageRepository: context.read<LocalStorageRepository>(),
          loginRepository: context.read<LoginRepository>(),
          emailValidator: context.read<EmailValidator>(),
          passwordValidator: context.read<PasswordValidator>()),
      child: Builder(builder: (context) {
        return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.isLogInComplete) {
                openHomeScreen(context);
              }
              if (state.isLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              if (state.showSnackBar) {
                _showValidatorError(context, state.isEmailValid);
              }
            },
            child: buildScaffold(context));
      }),
    );
  }

  Widget buildScaffold(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    return LoaderOverlay(
      overlayColor: AppColors.loaderBackground,
      overlayWidgetBuilder: (context) {
        return const AppLoadingOverlay();
      },
      child: Scaffold(
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
                          bloc.add(ChangeSaveTokenEvent());
                        }),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: TextButton(
                  onPressed: () {
                    bloc.add(LogInUserEvent());
                  },
                  child: Text(context.strings.loginScreenButton),
                ),
              ),
              // const SliverFillRemaining(),
            ],
          ),
        ),
      ),
    );
  }

  void _showValidatorError(BuildContext context, bool isEmailValid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: isEmailValid
            ? Text(
                context.strings.passwordValidatorError,
              )
            : Text(
                context.strings.emailValidatorError,
              ),
      ),
    );
  }

  void openHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return LoaderOverlay(
            overlayWidgetBuilder: (context) {
              return const AppLoadingOverlay();
            },
            overlayWholeScreen: false,
            child: const HomeScreen());
      }),
    );
  }
}

class _LoginTextFields extends StatelessWidget {
  const _LoginTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
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
            onTap: () {
              bloc.add(ChangePasswordVisibilityEvent());
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
