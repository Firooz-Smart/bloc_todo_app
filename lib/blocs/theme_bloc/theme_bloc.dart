import 'package:bloc/bloc.dart';
import 'package:bloc_todo/blocs/theme_bloc/theme_event.dart';
import 'package:bloc_todo/blocs/theme_bloc/theme_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial(isDarkMode: false)) {
    on<DarkModeOnEvent>(
        (event, emit) => emit(const ThemeState(darkModeOn: true)));
    on<DarkModeOffEvent>(
        (event, emit) => emit(const ThemeState(darkModeOn: false)));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(ThemeState state) => state.toMap();
}
