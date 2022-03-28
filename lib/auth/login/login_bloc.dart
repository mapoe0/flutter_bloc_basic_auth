import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_test/auth/auth_repository.dart';
import 'package:flutter_bloc_test/auth/form_submission_status.dart';
import 'package:flutter_bloc_test/auth/login/login_event.dart';
import 'package:flutter_bloc_test/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc(
    this.authRepository,
  ) : super(LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginUsernameChanged) {
        emit(state.copyWith(username: event.username));
      } else if (event is LoginPasswordChanged) {
        emit(state.copyWith(password: event.password));
      } else if (event is LoginSubmitted) {
        emit(state.copyWith(formStatus: FormSubmitting()));
        try {
          await authRepository.login();

          emit(state.copyWith(formStatus: SubmessionSucess()));
        } on Exception catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      }
    });
  }
  /*
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    }
    // paswword updated
    else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    // form submitted
    else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        await authRepository.login();
        yield state.copyWith(formStatus: SubmessionSucess());
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e));
      }
    }
  }*/
}
