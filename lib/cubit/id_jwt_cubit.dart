import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:memory_app/model/id_jwt.dart';

class IdJwtCubit extends Cubit<IdJwtCubitState> {
  late http.Client _client;
  final String baseUrl = 'http://10.0.2.2:3000';

  IdJwtCubit() : super(InitIdJwtCubitState()) {
    _client = http.Client();
  }

  Future<void> Login(String loginId, String password) async {
    if (state is! LoginIdJwtCubitState) {
      try {
        final response = await _client.post(
          Uri.parse('$baseUrl/api/v1/login'),
          body: jsonEncode(<String, String>{
            'userId': loginId,
            'userPW': password,
          }),
        );
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final String accessToken = data['accessToken'];
          emit(LoginIdJwtCubitState(idJwt: IdJwt.login(loginId, accessToken)));
        } else if (response.statusCode == 401) {
          final String error = data['error'];
          late String message;
          if (error == 'Unauthorized') {
            message = '아이디 혹은 비밀번호가 틀렸습니다.';
          } else {
            message = '';
          }
          emit(LoginFailIdJwtCubitState(idJwt: state.idJwt, message: message));
        } else {
          throw Exception('Failed to login');
        }
      } catch (e) {
        emit(ErrorIdJwtCubitState(
            idJwt: state.idJwt, errorMessage: e.toString()));
      }
    }
  }

  Future<void> Logout() async {
    if (state is LoginIdJwtCubitState) {
      try {
        final response = await _client.get(
          Uri.parse('$baseUrl/api/v1/logout'),
          headers: <String, String>{
            'accessToken': state.idJwt.jwt!,
          },
        );
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String message = data['message'];
        if (response.statusCode == 200) {
          emit(LogoutIdJwtCubitState(idJwt: IdJwt(id: '', jwt: '')));
        } else {
          throw Exception('Failed to login');
        }
      } catch (e) {
        emit(ErrorIdJwtCubitState(
            idJwt: state.idJwt, errorMessage: e.toString()));
      }
    }
    emit(LogoutIdJwtCubitState(idJwt: IdJwt.logout()));
  }

  Future<void> Delete() async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/api/v1/account'),
          headers: <String, String>{
            'accessToken': state.idJwt.jwt!,
          });
      if (response.statusCode == 200) {
        emit(LogoutIdJwtCubitState(idJwt: IdJwt(id: '', jwt: '')));
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = data['message'];
        emit(LogoutFailIdJwtCubitState(idJwt: state.idJwt, message: message));
      }
    } catch (e) {
      emit(
          LogoutFailIdJwtCubitState(idJwt: state.idJwt, message: e.toString()));
    }
  }

  Future<void> signUp(String name, String userId, String userPw) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/v1/signup'),
          body: jsonEncode(<String, String>{
            'name': name,
            'userId': userId,
            'userPw': userPw,
          }));
      if (response.statusCode == 200) {
        await Login(userId, userPw);
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> close() {
    _client.close();
    return super.close();
  }
}

abstract class IdJwtCubitState extends Equatable {
  final IdJwt idJwt;

  const IdJwtCubitState({required this.idJwt});
}

class InitIdJwtCubitState extends IdJwtCubitState {
  InitIdJwtCubitState() : super(idJwt: IdJwt.init());

  @override
  List<Object?> get props => [idJwt];
}

class LoginIdJwtCubitState extends IdJwtCubitState {
  const LoginIdJwtCubitState({required super.idJwt});

  @override
  List<Object?> get props => [idJwt];
}

class LoginFailIdJwtCubitState extends IdJwtCubitState {
  String message;

  LoginFailIdJwtCubitState({required super.idJwt, required this.message});

  @override
  List<Object?> get props => [idJwt, message];
}

class LogoutIdJwtCubitState extends IdJwtCubitState {
  const LogoutIdJwtCubitState({required super.idJwt});

  @override
  List<Object?> get props => [idJwt];
}

class LogoutFailIdJwtCubitState extends IdJwtCubitState {
  String message;

  LogoutFailIdJwtCubitState({required super.idJwt, required this.message});

  @override
  List<Object?> get props => [idJwt, message];
}

class ErrorIdJwtCubitState extends IdJwtCubitState {
  String errorMessage;

  ErrorIdJwtCubitState({required super.idJwt, required this.errorMessage});

  @override
  List<Object?> get props => [idJwt, errorMessage];
}
