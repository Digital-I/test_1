import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'mod_theme_event.dart';
part 'mod_theme_state.dart';

class ModThemeBloc extends Bloc<ModThemeEvent, ModThemeState> {
  ModThemeBloc() : super(DarkModThemeState()) {
    on<DarkModThemeEvent>(
        (DarkModThemeEvent event, Emitter<ModThemeState> emit) {
      emit(DarkModThemeState());
    });
    on<LightModThemeEvent>(
        (LightModThemeEvent event, Emitter<ModThemeState> emit) {
      emit(LightModThemeState());
    });
  }
}
