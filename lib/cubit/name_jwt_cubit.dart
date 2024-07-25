import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:memory_app/model/name_jwt.dart';

class NameJwtCubit extends Cubit<IdJwtCubitState> {
  NameJwtCubit() : super(InitIdJwtCubitState());

  Login(String loginJwt, String name) {
    emit(LoginIdJwtCubitState(idJwt: NameJwt.login(loginJwt, name)));
  }

  Logout() {
    emit(LogoutIdJwtCubitState(idJwt: NameJwt.logout()));
  }

}

abstract class IdJwtCubitState extends Equatable {
  final NameJwt idJwt;

  const IdJwtCubitState({required this.idJwt});
}

class InitIdJwtCubitState extends IdJwtCubitState {
  InitIdJwtCubitState() : super(idJwt: NameJwt.init());

  @override
  List<Object?> get props => [idJwt];
}

class LoginIdJwtCubitState extends IdJwtCubitState {
  const LoginIdJwtCubitState({required super.idJwt});

  @override
  List<Object?> get props => [idJwt];
}

class LogoutIdJwtCubitState extends IdJwtCubitState {
  const LogoutIdJwtCubitState({required super.idJwt});

  @override
  List<Object?> get props => [idJwt];
}
