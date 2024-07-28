import 'dart:convert';

import 'package:equatable/equatable.dart';

class MecoQuestion extends Equatable {
  String mecoDate;
  String contents;
  List<String> questions;
  List<String> answers;

  MecoQuestion(
      {required this.mecoDate,
      required this.contents,
      required this.questions,
      required this.answers});

  MecoQuestion.init()
      : this(mecoDate: '', contents: '', questions: [], answers: []);

  factory MecoQuestion.fromJson(String date, Map<String, dynamic> json) {
    return MecoQuestion(
      mecoDate: date,
      contents: json['contents'] as String? ?? '',
      questions: (json['questions'] as List<dynamic>?)
          ?.map((q) => q.toString())
          .toList() ?? [],
      answers: (json['answers'] as List<dynamic>?)
          ?.map((a) => a.toString())
          .toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [mecoDate, contents, questions, answers];
}
