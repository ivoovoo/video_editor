import 'package:flutter_bloc/flutter_bloc.dart';
import 'nav_event.dart';
import 'nav_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigateToScreenA()) {
    on<GoToScreenB>((event, emit) {
      emit(NavigateToScreenB());
    });
    on<GoToScreenA>((event, emit) {
      emit(NavigateToScreenA());
    });
  }
}
