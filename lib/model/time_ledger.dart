import 'dart:convert';

import 'package:equatable/equatable.dart';

class TimeLedger extends Equatable {
  final int recordId;
  final String emotion;
  final String category;
  final String contents;
  final double takedTime;

  TimeLedger(
      {required this.recordId,
      required this.emotion,
      required this.category,
      required this.contents,
      required this.takedTime});

  factory TimeLedger.fromJson(Map<String, dynamic> json) {
    return TimeLedger(
      recordId: json['recordId'],
      emotion: utf8.decode(json['emotion'].codeUnits),
      category: utf8.decode(json['category'].codeUnits),
      contents: utf8.decode(json['contents'].codeUnits),
      takedTime: json['takedTime'],
    );
  }

  @override
  List<Object?> get props => [recordId, emotion, category, contents, takedTime];
}
