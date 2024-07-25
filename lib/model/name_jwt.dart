import 'package:equatable/equatable.dart';

class NameJwt extends Equatable {
  String? jwt;

  String? name;

  NameJwt({
    this.jwt,
    this.name,
  });

  NameJwt.init() : this();

  factory NameJwt.login(String jwt, String name) {
    return NameJwt(
      jwt: jwt,
      name: name,
    );
  }

  factory NameJwt.logout() {
    return NameJwt(jwt: null, name: null);
  }

  @override
  List<Object?> get props => [jwt, name];
}
