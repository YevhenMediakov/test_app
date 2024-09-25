import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/domain/repository/local_storage_repository.dart';
import 'package:test_prj/domain/repository/login_repository.dart';
import 'package:test_prj/domain/validators/email_validator.dart';
import 'package:test_prj/domain/validators/password_validator.dart';
import 'package:test_prj/presentation/components/extensions/build_context_extensions.dart';
import 'package:test_prj/presentation/components/text_field/app_text_field.dart';
import 'package:test_prj/presentation/components/text_field/show_password_button.dart';
import 'package:test_prj/presentation/home_screen/home_screen.dart';
import 'package:test_prj/resources/app_text_styles.dart';

import 'login_cubit.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
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
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return BlocProvider(
        create: (context) => LoginCubit(
            localStorageRepository: context.read<LocalStorageRepository>(),
            loginRepository: context.read<LoginRepository>(),
            emailValidator: context.read<EmailValidator>(),
            passwordValidator: context.read<PasswordValidator>()),
        child: Builder(builder: (context) {
          return BlocConsumer(
              bloc: context.read<LoginCubit>(),
              listener: (context, state) {
                if (context.read<LoginCubit>().state.isLogInComplete) {
                  openHomeScreen();
                }
                if (context.read<LoginCubit>().state.isLoading) {
                  context.showLoading();
                } else {
                  context.hideLoading();
                }
              },
              builder: (context, state) {
              _emailController.addListener(() {
            context.read<LoginCubit>().updateEmail(_emailController.text);
          });

          _passwordController.addListener(() {
          context.read<LoginCubit>().updatePassword(_passwordController.text);
          });
          return Scaffold(
                  resizeToAvoidBottomInset: false,
                  // backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Text(context.strings.loginScreenTitle,
                                style: AppTextStyles.h1Bold),
                            const SizedBox(height: 24),
                            _LoginTextFields(
                              emailController: _emailController,
                              passwordController: _passwordController,
                              isPasswordObscureText: context
                                  .watch<LoginCubit>()
                                  .state
                                  .isPasswordObscureText,
                              onPasswordObscureTextChange: context
                                  .read<LoginCubit>()
                                  .changePasswordVisibility,
                              emailInvalid: context
                                      .watch<LoginCubit>()
                                      .state
                                      .isEmailValid ==
                                  false,
                              passwordInvalid: context
                                      .watch<LoginCubit>()
                                      .state
                                      .isPasswordValid ==
                                  false,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(context.strings.loginScreenCheckBox,
                                    style: AppTextStyles.bodyL),
                                Checkbox(
                                    value: context
                                        .watch<LoginCubit>()
                                        .state
                                        .isCheckboxValid,
                                    onChanged: (value) {
                                      context
                                          .read<LoginCubit>()
                                          .changeCheckbox();
                                    }),
                              ],
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: context.read<LoginCubit>().loginUser,
                              child: Text(context.strings.loginScreenButton),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ));});
        }));
  }

  void openHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return const HomeScreen();
      }),
    );
  }
}

class _LoginTextFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordObscureText;
  final VoidCallback onPasswordObscureTextChange;
  final bool emailInvalid;
  final bool passwordInvalid;

  const _LoginTextFields({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordObscureText,
    required this.onPasswordObscureTextChange,
    required this.emailInvalid,
    required this.passwordInvalid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        AppTextField(
          controller: emailController,
          hintText: context.strings.loginScreenEmail,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.emailAddress,
          forceErrorBorder: emailInvalid,
        ),
        const SizedBox(height: 20),
        AppTextField(
          controller: passwordController,
          obscureText: isPasswordObscureText,
          hintText: context.strings.loginScreenPassword,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.visiblePassword,
          forceErrorBorder: passwordInvalid,
          suffixIcon: ShowPasswordButton(
            show: !isPasswordObscureText,
            onTap: onPasswordObscureTextChange,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
