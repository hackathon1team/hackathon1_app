import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory_app/model/time_ledger.dart';
import 'package:memory_app/model/time_ledger_list.dart';
import 'package:http/http.dart' as http;

class TimeLedgerListCubit extends Cubit<TimeLedgerListCubitState> {
  final _baseUrl = 'https://memorymeta.store/api/v1/time-ledger';

  TimeLedgerListCubit() : super(InitTimeLedgerListCubitState());

  loadTimeLedgerList(String date, String jwt) async {
    try {
      if (state is LoadingTimeLedgerListCubitState ||
          state is ErrorTimeLedgerListCubitState) {
        return;
      }
      emit(LoadingTimeLedgerListCubitState(
          timeLedgerList: state.timeLedgerList));

      final response = await http.get(
        Uri.parse('$_baseUrl/records/date/$date'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Accept-Charset': 'utf-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<TimeLedger> timeLedgers =
            jsonList.map((json) => TimeLedger.fromJson(json)).toList();

        final TimeLedgerList newTimeLedgerList = TimeLedgerList(
          timeLedgerList: timeLedgers,
          date: date,
        );

        emit(LoadedTimeLedgerListCubitState(timeLedgerList: newTimeLedgerList));
      } else {
        throw Exception('시간가계부 로드 실패: ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorTimeLedgerListCubitState(
        timeLedgerList: state.timeLedgerList,
        errorMessage: e.toString(),
      ));
    }
  }

  addTimeLedger(String date, String emotion, String emotionCategory,
      String category, String contents, double takedTime, String jwt) async {
    try {
      if (state is LoadingTimeLedgerListCubitState ||
          state is ErrorTimeLedgerListCubitState) {
        return;
      }
      emit(LoadingTimeLedgerListCubitState(
          timeLedgerList: state.timeLedgerList));
      final response = await http.post(Uri.parse('$_baseUrl/record'),
          headers: {
            'Authorization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'ledgerDate': date,
            'emotion': emotion,
            'emotionCategory': emotionCategory,
            'category': category,
            'contents': contents,
            'takedTime': takedTime,
          }));
      if (response.statusCode == 201) {
        emit(LoadedTimeLedgerListCubitState(
            timeLedgerList: state.timeLedgerList));
        loadTimeLedgerList(date, jwt);
      } else {
        throw Exception('시간가계부 추가 실패 ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorTimeLedgerListCubitState(
          timeLedgerList: state.timeLedgerList, errorMessage: e.toString()));
    }
  }

  deleteTimeLedger(int recordId, String jwt) async {
    try {
      if (state is LoadingTimeLedgerListCubitState ||
          state is ErrorTimeLedgerListCubitState) {
        return;
      }
      emit(LoadingTimeLedgerListCubitState(
          timeLedgerList: state.timeLedgerList));
      final response = await http.delete(
        Uri.parse('$_baseUrl/records/$recordId'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        emit(LoadedTimeLedgerListCubitState(
            timeLedgerList: state.timeLedgerList));
        loadTimeLedgerList(state.timeLedgerList.date, jwt);
      } else {
        throw Exception('시간가계부 삭제 실패 ${response.statusCode}');
      }
    } catch (e) {
      emit(ErrorTimeLedgerListCubitState(
          timeLedgerList: state.timeLedgerList, errorMessage: e.toString()));
    }
  }

  void logout(){
    emit(InitTimeLedgerListCubitState());
  }
}

abstract class TimeLedgerListCubitState extends Equatable {
  final TimeLedgerList timeLedgerList;

  const TimeLedgerListCubitState({required this.timeLedgerList});
}

class InitTimeLedgerListCubitState extends TimeLedgerListCubitState {
  InitTimeLedgerListCubitState() : super(timeLedgerList: TimeLedgerList.init());

  @override
  List<Object?> get props => [timeLedgerList];
}

class LoadingTimeLedgerListCubitState extends TimeLedgerListCubitState {
  const LoadingTimeLedgerListCubitState({required super.timeLedgerList});

  @override
  List<Object?> get props => [timeLedgerList];
}

class LoadedTimeLedgerListCubitState extends TimeLedgerListCubitState {
  const LoadedTimeLedgerListCubitState({required super.timeLedgerList});

  @override
  List<Object?> get props => [timeLedgerList];
}

class ErrorTimeLedgerListCubitState extends TimeLedgerListCubitState {
  String errorMessage;

  ErrorTimeLedgerListCubitState(
      {required super.timeLedgerList, required this.errorMessage});

  @override
  List<Object?> get props => [timeLedgerList, errorMessage];
}
