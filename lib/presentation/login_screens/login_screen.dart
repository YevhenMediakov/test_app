import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj/_infra/service_locator/app_service_locator.dart';
import 'package:test_prj/presentation/components/extensions/build_context_extensions.dart';
import 'package:test_prj/presentation/components/text_field/app_text_field.dart';
import 'package:test_prj/presentation/components/text_field/show_password_button.dart';
import 'package:test_prj/resources/app_text_styles.dart';

import 'login_cubit.dart';
import 'login_state.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  late final LoginCubit _screenBloc = getIt<LoginCubit>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      _screenBloc.updateEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _screenBloc.updatePassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _screenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: _screenBloc,
      listener: (context, state) {
        if (state.isCheckboxValid ?? false) {
          _openHomeScreen();
        }
        // if (state.exception != null) {
        //   context.showErrorException(state.exception);
        // }
        //
        // if (state.isLoading) {
        //   context.showLoading();
        // } else {
        //   context.hideLoading();
        // }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(context.strings.loginScreenTitle, style: AppTextStyles.h1Bold),
                    const SizedBox(height: 24),
                    _LoginTextFields(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      isPasswordObscureText: state.isPasswordObscureText,
                      onPasswordObscureTextChange:
                          _screenBloc.isPasswordObscureText,
                      emailInvalid: state.isEmailValid == false,
                      passwordInvalid: state.isPasswordValid == false,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(context.strings.loginScreenCheckBox,
                            style: AppTextStyles.bodyL),
                        Checkbox(
                            value: state.isCheckboxValid ?? false,
                            onChanged: (value) {}),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: _screenBloc.loginUser,
                        child: Text(context.strings.loginScreenButton),

                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _openHomeScreen() {
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
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
