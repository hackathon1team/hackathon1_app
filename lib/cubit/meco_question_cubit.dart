import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory_app/model/meco_question.dart';
import 'package:http/http.dart' as http;

class MecoQuestionCubit extends Cubit<MecoQuestionCubitState> {
  final _baseUrl = 'http://15.165.154.126:8080/api/v1/';

  MecoQuestionCubit() : super(InitMecoQuestionCubitState());
}

abstract class MecoQuestionCubitState extends Equatable {
  final MecoQuestion mecoQuestion;

  const MecoQuestionCubitState({required this.mecoQuestion});
}

class InitMecoQuestionCubitState extends MecoQuestionCubitState {
  InitMecoQuestionCubitState() : super(mecoQuestion: MecoQuestion.init());

  @override
  List<Object?> get props => [mecoQuestion];
}

class LoadingMecoQuestionCubitState extends MecoQuestionCubitState {
  LoadingMecoQuestionCubitState({required super.mecoQuestion});

  @override
  List<Object?> get props => [mecoQuestion];
}

class LoadedMecoQuestionCubitState extends MecoQuestionCubitState {
  LoadedMecoQuestionCubitState({required super.mecoQuestion});

  @override
  List<Object?> get props => [mecoQuestion];
}

class ErrorMecoQuestionCubitState extends MecoQuestionCubitState {
  String errorMessage;

  ErrorMecoQuestionCubitState(
      {required super.mecoQuestion, required this.errorMessage});

  @override
  List<Object?> get props => [mecoQuestion, errorMessage];
}
