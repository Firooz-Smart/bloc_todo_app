import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool darkModeOn;
  const ThemeState({required this.darkModeOn});

  @override
  // TODO: implement props
  List<Object?> get props => [darkModeOn];

  Map<String, dynamic> toMap() {
    return {'darkModeOn': darkModeOn};
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(darkModeOn: map['darkModeOn']);
  }
}

class ThemeInitial extends ThemeState {
  const ThemeInitial({required bool isDarkMode})
      : super(darkModeOn: isDarkMode);
}
