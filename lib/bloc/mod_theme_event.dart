part of 'mod_theme_bloc.dart';

@immutable
abstract class ModThemeEvent {}

class DarkModThemeEvent extends ModThemeEvent {}

class LightModThemeEvent extends ModThemeEvent {}
