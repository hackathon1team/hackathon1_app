import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory_app/model/static_list_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/static_model.dart';

class StaticListCubit extends Cubit<StaticListCubitState> {
  final _baseUrl = 'https://memorymeta.store/api/v1/time-ledger';

  StaticListCubit() : super(InitStaticListCubitState());

  Future<void> loadStaticList(String jwt) async {
    try {
      if (state is LoadingStaticListCubitState) {
        return;
      }
      emit(LoadingStaticListCubitState(staticList: state.staticList));
      final response = await http.get(
        Uri.parse('$_baseUrl/statistics'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Accept-Charset': 'utf-8',
        },
      );
      print('코드: ${response.statusCode}');
      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> json = jsonDecode(decodedBody);
        print('받은 JSON: $json'); // 전체 JSON 출력

        List<TimeSpent> timeSpent = (json['timeSpent'] as List?)
                ?.map((item) => TimeSpent(
                      category: item['category'] as String? ?? '',
                      hours: item['hours'] as double?? 0,
                      percentage: item['percentage'] as double ?? 0,
                    ))
                .toList() ??
            [];
        print('타임스펜트: $timeSpent');

        ComparisonWithLastMonth comparisonWithLastMonth;

        final comparisonData =
            json['comparisonWithLastMonth'] as Map<String, dynamic>? ?? {};
        comparisonWithLastMonth = ComparisonWithLastMonth(
          previousCategory: comparisonData['previousCategory'] as String? ?? '',
          previousMonth: comparisonData['previousMonth']?.toString() ?? '',
          previousHours: comparisonData['previousHours'] ?? 0,
          currentCategory: comparisonData['currentCategory'] as String? ?? '',
          currentMonth: comparisonData['currentMonth']?.toString() ?? '',
          currentHours: comparisonData['currentHours'] ?? 0,
        );

        List<EmotionsSummary> emotionsSummary =
            (json['emotionsSummary'] as List?)
                    ?.map((item) => EmotionsSummary(
                          type: item['type'] as String? ?? '',
                          count: item['count'] as int? ?? 0,
                        ))
                    .toList() ??
                [];

        List<Emotions> positiveEmotions = (json['positiveEmotions'] as List?)
                ?.map((item) => Emotions(
                      emotion: item['emotions'] as String? ?? '',
                      count: item['count'] as int? ?? 0,
                    ))
                .toList() ??
            [];

        List<Emotions> neutralEmotions = (json['neutralEmotions'] as List?)
                ?.map((item) => Emotions(
                      emotion: item['emotions'] as String? ?? '',
                      count: item['count'] as int? ?? 0,
                    ))
                .toList() ??
            [];

        List<Emotions> negativeEmotions = (json['negativeEmotions'] as List?)
                ?.map((item) => Emotions(
                      emotion: item['emotions'] as String? ?? '',
                      count: item['count'] as int? ?? 0,
                    ))
                .toList() ??
            [];

        final staticList = StaticListModel(
          timeSpent: timeSpent,
          comparisonWithLastMonth: comparisonWithLastMonth,
          emotionsSummary: emotionsSummary,
          positiveEmotions: positiveEmotions,
          neutralEmotions: neutralEmotions,
          negativeEmotions: negativeEmotions,
        );

        emit(LoadedStaticListCubitState(staticList: staticList));
      } else {
        throw Exception('통계 불러오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('전체 처리 중 오류: $e');
      emit(ErrorStaticListCubitState(
          staticList: state.staticList, errorMessage: e.toString()));
    }
  }

  void logout() {
    emit(InitStaticListCubitState());
  }
}

abstract class StaticListCubitState extends Equatable {
  final StaticListModel staticList;

  const StaticListCubitState({required this.staticList});
}

class InitStaticListCubitState extends StaticListCubitState {
  InitStaticListCubitState() : super(staticList: StaticListModel.init());

  @override
  List<Object?> get props => [staticList];
}

class LoadingStaticListCubitState extends StaticListCubitState {
  const LoadingStaticListCubitState({required super.staticList});

  @override
  List<Object?> get props => [staticList];
}

class LoadedStaticListCubitState extends StaticListCubitState {
  const LoadedStaticListCubitState({required super.staticList});

  @override
  List<Object?> get props => [staticList];
}

class ErrorStaticListCubitState extends StaticListCubitState {
  String errorMessage;

  ErrorStaticListCubitState(
      {required super.staticList, required this.errorMessage});

  @override
  List<Object?> get props => [staticList, errorMessage];
}
