import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/auth/auth_repository.dart';
import 'package:flutter_bloc_test/auth/form_submission_status.dart';
import 'package:flutter_bloc_test/auth/login/login_bloc.dart';
import 'package:flutter_bloc_test/auth/login/login_event.dart';
import 'package:flutter_bloc_test/auth/login/login_state.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(context.read<AuthRepository>()),
      child: _loginForm(),
    ));
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_usernameField(), _passwordField(), _loginButton()],
          )),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: false,
          decoration: const InputDecoration(
              icon: Icon(Icons.person), hintText: 'Username'),
          validator: (value) =>
              state.isValidUsername ? null : 'Username is too short',
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.security), hintText: 'Password'),
          validator: (value) =>
              state.isValidPassword ? null : 'Password is too short',
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: ((context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: const Text('login'));
    }));
  }
}
