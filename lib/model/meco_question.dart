import 'package:equatable/equatable.dart';

class MecoQuestion extends Equatable {
  String contents;
  List<String> questions;
  List<String> answers;

  MecoQuestion(
      {required this.contents, required this.questions, required this.answers});

  MecoQuestion.init() : this(contents: '', questions: [], answers: []);

  factory MecoQuestion.fromJson(Map<String, dynamic> json) {
    return MecoQuestion(
        contents: json['contents'],
        questions: json['questions'],
        answers: json['answers']);
  }

  @override
  List<Object?> get props => [contents, questions, answers];
}
