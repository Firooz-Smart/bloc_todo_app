import 'package:equatable/equatable.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DarkModeOnEvent extends ThemeEvent {}

class DarkModeOffEvent extends ThemeEvent {}
