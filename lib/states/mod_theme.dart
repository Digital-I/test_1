import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModTheme extends Bloc<ModEvent, ColorScheme> {
  ModTheme() : super(ColorScheme.dark()) {
    on<DarkModEvent>(_onDarkMod);
    on<LightModEvent>(_onLightMod);
  }

  _onDarkMod(DarkModEvent event, Emitter<ColorScheme> emit){
    emit(ColorScheme.dark());
  }
  _onLightMod(LightModEvent event, Emitter<ColorScheme> emit){
    emit(ColorScheme.light());
  }
}

abstract class ModEvent {}
class DarkModEvent extends ModEvent {}
class LightModEvent extends ModEvent {}