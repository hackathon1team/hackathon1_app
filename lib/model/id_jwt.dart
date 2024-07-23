import 'package:equatable/equatable.dart';

class IdJwt extends Equatable {
  String? id;
  String? jwt;

  // String? name;

  IdJwt({
    this.id,
    this.jwt,
    // this.name,
  });

  IdJwt.init() : this();

  factory IdJwt.login(String id, String jwt
      // , String name
      ) {
    return IdJwt(
      id: id,
      jwt: jwt,
      // name: name,
    );
  }

  factory IdJwt.logout() {
    return IdJwt(
      id: null, jwt: null,
      // name: null
    );
  }

  @override
  List<Object?> get props => [
        id, jwt,
        // name
      ];
}
