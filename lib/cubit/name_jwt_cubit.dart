import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory_app/model/name_jwt.dart';

class NameJwtCubit extends Cubit<IdJwtCubitState> {
  NameJwtCubit() : super(InitIdJwtCubitState());

  Login(String loginJwt, String name) {
    emit(LoginIdJwtCubitState(nameJwt: NameJwt.login(loginJwt, name)));
  }

  Logout() {
    emit(LogoutIdJwtCubitState(nameJwt: NameJwt.logout()));
  }

}

abstract class IdJwtCubitState extends Equatable {
  final NameJwt nameJwt;

  const IdJwtCubitState({required this.nameJwt});
}

class InitIdJwtCubitState extends IdJwtCubitState {
  InitIdJwtCubitState() : super(nameJwt: NameJwt.init());

  @override
  List<Object?> get props => [nameJwt];
}

class LoginIdJwtCubitState extends IdJwtCubitState {
  const LoginIdJwtCubitState({required super.nameJwt});

  @override
  List<Object?> get props => [nameJwt];
}

class LogoutIdJwtCubitState extends IdJwtCubitState {
  const LogoutIdJwtCubitState({required super.nameJwt});

  @override
  List<Object?> get props => [nameJwt];
}
