import 'package:capcut/UI/edit.dart';
import 'package:capcut/UI/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Nav_BLoC/nav_bloc.dart';
import '../Nav_BLoC/nav_state.dart';

class Project extends StatelessWidget {
  const Project({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        if (state is NavigateToScreenA) {
          return const HomeWidget();
        } else if (state is NavigateToScreenB) {
          return  VideoEditorScreen();
        }
        return const Center(
          child: Text('error'),
        );
      },
    );
  }
}
