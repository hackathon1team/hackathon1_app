import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/model/meco_question.dart';
import 'package:http/http.dart' as http;

class MecoQuestionCubit extends Cubit<MecoQuestionCubitState> {
  final _baseUrl = 'http://15.165.154.126:8080/api/v1';

  MecoQuestionCubit() : super(InitMecoQuestionCubitState());

  Future<List<String>> loadContents(String jwt) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/time-ledger/today-records'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Accept-Charset': 'utf-8',
        },
      );
      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decodedBody);
        return (data['contentsList'] as List<dynamic>).cast<String>();
      } else {
        throw Exception('사건 불러오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('사건 불러오기 실패: ${e.toString()}');
    }
  }

  Future<void> answerQuestion(String contents, List<String> questions, List<String> answers, String jwt) async {
    try {
      if (state is LoadingMecoQuestionCubitState) return;

      emit(LoadingMecoQuestionCubitState(mecoQuestion: state.mecoQuestion));
      final String mecoDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      final response = await http.post(
        Uri.parse('$_baseUrl/meco/questions'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'mecoDate': mecoDate,
          'contents': contents,
          'questions': questions,
          'answers': answers,
        }),
      );

      if (response.statusCode == 201) {
        emit(LoadedMecoQuestionCubitState(
          mecoQuestion: MecoQuestion(
            mecoDate: mecoDate,
            contents: contents,
            questions: questions,
            answers: answers,
          ),
        ));
      } else {
        throw Exception('답변 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorMecoQuestionCubitState(
        mecoQuestion: state.mecoQuestion,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadQuestionAnswer(String date, String jwt) async {
    try {
      if (state is LoadingMecoQuestionCubitState) return;

      emit(LoadingMecoQuestionCubitState(mecoQuestion: state.mecoQuestion));
      final response = await http.get(
        Uri.parse('$_baseUrl/meco/questions/$date'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Accept-Charset': 'utf-8',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> json = jsonDecode(decodedBody);
        emit(LoadedMecoQuestionCubitState(
          mecoQuestion: MecoQuestion.fromJson(date, json),
        ));
      } else {
        throw Exception('질문 답변 불러오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorMecoQuestionCubitState(
        mecoQuestion: state.mecoQuestion,
        errorMessage: '메코의 질문 답변 불러오기 실패: ${e.toString()}',
      ));
    }
  }

  void markAnswersChecked() {
    if (state is LoadedMecoQuestionCubitState) {
      emit(LoadedMecoQuestionCubitState(
        mecoQuestion: state.mecoQuestion,
        hasCheckedAnswers: true,
      ));
    }
  }
}

abstract class MecoQuestionCubitState extends Equatable {
  final MecoQuestion mecoQuestion;
  final bool hasCheckedAnswers;

  const MecoQuestionCubitState({
    required this.mecoQuestion,
    this.hasCheckedAnswers = false,
  });

  @override
  List<Object?> get props => [mecoQuestion, hasCheckedAnswers];
}

class InitMecoQuestionCubitState extends MecoQuestionCubitState {
  InitMecoQuestionCubitState() : super(mecoQuestion: MecoQuestion.init());
}

class LoadingMecoQuestionCubitState extends MecoQuestionCubitState {
  LoadingMecoQuestionCubitState({required super.mecoQuestion});
}

class LoadedMecoQuestionCubitState extends MecoQuestionCubitState {
  LoadedMecoQuestionCubitState({
    required super.mecoQuestion,
    super.hasCheckedAnswers = false,
  });
}

class ErrorMecoQuestionCubitState extends MecoQuestionCubitState {
  final String errorMessage;

  ErrorMecoQuestionCubitState({
    required super.mecoQuestion,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [mecoQuestion, errorMessage, hasCheckedAnswers];
}