import 'package:capcut/Nav_BLoC/nav_bloc.dart';
import 'package:capcut/UI/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/edit.dart';
import 'UI/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => NavigationBloc(),
          child: Project()),
      debugShowCheckedModeBanner: false,
    );
  }
}
