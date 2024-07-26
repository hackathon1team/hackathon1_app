import 'dart:convert';

import 'package:http/http.dart' as http;

class Account {
  final String _baseUrl = 'http://15.165.154.126:8080/api/v1';

  // 'http://3.36.130.52:8080/api/v1';

  Future<int> signup(String name, String userId, String userPw) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/signUp'),
          headers: {
            'Content-Type': 'application/json', // 올바른 Content-Type 설정
          },
          body: jsonEncode({
            'name': name,
            'userId': userId,
            'userPw': userPw,
          }));
      return response.statusCode;
    } catch (e) {
      throw Exception('회원가입 실패\n ${e.toString()}');
    }
  }

  Future<bool> checkDuplicated(String userId) async {
    try {
      final response = await http.get(
          Uri.parse('$_baseUrl/check-duplication').replace(queryParameters: {
        'userId': userId,
      }));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('중복검사 실패\n ${e.toString()}');
    }
  }

  Future<List<String>> login(String userId, String userPW) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'userPw': userPW,
        }),
      );
      print('로그인: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String accessToken = data['accessToken'];
        // final String userName = data['userName'];
        return [accessToken, '이승훈'];
      } else if (response.statusCode == 401) {
        return ['login failed'];
      } else {
        throw Exception('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('로그인 실패: ${e.toString()}');
    }
  }

  Future<int> logout(String jwt) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/logout'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      return response.statusCode;
    } catch (e) {
      throw Exception('로그아웃 실패: ${e.toString()}');
    }
  }

  Future<int> delete(String jwt) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/account'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      return response.statusCode;
    } catch (e) {
      throw Exception('회원 탈퇴 실패: ${e.toString()}');
    }
  }
}
