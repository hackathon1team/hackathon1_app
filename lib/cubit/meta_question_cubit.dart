import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/model/meco_question.dart';
import 'package:http/http.dart' as http;
import 'package:memory_app/model/meta_question.dart';

class MetaQuestionCubit extends Cubit<MetaQuestionCubitState> {
  final _baseUrl = 'https://memorymeta.store/api/v1';

  MetaQuestionCubit() : super(InitMetaQuestionCubitState());

  Future<void> answerQuestion(List<String> answers, String jwt) async {
    try {
      if (state is LoadingMetaQuestionCubitState) return;

      emit(LoadingMetaQuestionCubitState(metaQuestion: state.metaQuestion));

      final response = await http.patch(
        Uri.parse('$_baseUrl/meta-questions'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'answers': answers,
        }),
      );
      print('코드: ${response.statusCode}');

      if (response.statusCode == 200) {
        emit(LoadedMetaQuestionCubitState(
          metaQuestion: MetaQuestion.fromJson(answers)
        ));
      } else {
        throw Exception('답변 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorMetaQuestionCubitState(
        metaQuestion: state.metaQuestion,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> loadQuestionAnswer(String jwt) async {
    try {
      if (state is LoadingMetaQuestionCubitState) return;

      emit(LoadingMetaQuestionCubitState(metaQuestion: state.metaQuestion));
      final response = await http.get(
        Uri.parse('$_baseUrl/meta-questions'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Accept-Charset': 'utf-8',
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> json = jsonDecode(decodedBody);
        if (json.containsKey('answers') && json['answers'] is List) {
          final List<String> answers = List<String>.from(json['answers']);
          print('answer: $answers');
          emit(LoadedMetaQuestionCubitState(
            metaQuestion: MetaQuestion.fromJson(answers),
          ));
        } else {
          emit(LoadedMetaQuestionCubitState(
              metaQuestion: MetaQuestion(
                  answer1: '',
                  answer2: '',
                  answer3: '',
                  answer4: '',
                  answer5: '')));
        }
      } else {
        throw Exception('질문 답변 불러오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorMetaQuestionCubitState(
        metaQuestion: state.metaQuestion,
        errorMessage: '메타의 질문 답변 불러오기 실패: ${e.toString()}',
      ));
    }
  }

  void logout(){
    emit(InitMetaQuestionCubitState());
  }
}

abstract class MetaQuestionCubitState extends Equatable {
  final MetaQuestion metaQuestion;

  const MetaQuestionCubitState({
    required this.metaQuestion,
  });

  @override
  List<Object?> get props => [metaQuestion];
}

class InitMetaQuestionCubitState extends MetaQuestionCubitState {
  InitMetaQuestionCubitState() : super(metaQuestion: MetaQuestion.init());
}

class LoadingMetaQuestionCubitState extends MetaQuestionCubitState {
  LoadingMetaQuestionCubitState({required super.metaQuestion});
}

class LoadedMetaQuestionCubitState extends MetaQuestionCubitState {
  LoadedMetaQuestionCubitState({
    required super.metaQuestion,
  });
}

class ErrorMetaQuestionCubitState extends MetaQuestionCubitState {
  final String errorMessage;

  ErrorMetaQuestionCubitState({
    required super.metaQuestion,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [metaQuestion, errorMessage];
}
