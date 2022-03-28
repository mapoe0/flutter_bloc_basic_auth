import 'package:flutter_bloc_test/auth/form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  LoginState(
      {this.username = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  // pour changer que 1 des 2 champs
  LoginState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
