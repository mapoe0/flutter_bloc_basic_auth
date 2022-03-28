import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/auth/auth_repository.dart';
import 'package:flutter_bloc_test/auth/login/login_view.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter bloc tuto',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: RepositoryProvider(
          create: (context) => AuthRepository(),
          child: LoginView(),
        ));
  }
}
