import 'package:equatable/equatable.dart';

class MetaQuestion extends Equatable {
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String answer5;

  MetaQuestion(
      {required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.answer5});

  MetaQuestion.init()
      : this(answer1: '', answer2: '', answer3: '', answer4: '', answer5: '');

  factory MetaQuestion.fromJson(List<String> answers) {
    return MetaQuestion(
        answer1: answers[0],
        answer2: answers[1],
        answer3: answers[2],
        answer4: answers[3],
        answer5: answers[4]);
  }

  @override
  List<Object?> get props => [answer1, answer2, answer3, answer4, answer5];
}
