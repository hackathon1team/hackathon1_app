import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/account/account.dart';
import 'package:memory_app/screen/home_screen.dart';
import 'package:memory_app/screen/register_screen1.dart';

import '../const/colors.dart';
import '../cubit/name_jwt_cubit.dart';
import 'components/glassmorphism.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Glassmorphism(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/logo/logo.png'),

                  TextField(
                    controller: idController,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '아이디를 입력해주세요',
                      hintStyle: TextStyle(color: hintTextColor, fontSize: 12),
                      fillColor: Colors.black.withOpacity(0.12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // 원하는 모서리 반경
                        borderSide: BorderSide.none, // 경계선을 제거
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '비밀번호를 입력해주세요',
                      hintStyle: TextStyle(color: hintTextColor, fontSize: 12),
                      fillColor: Colors.black.withOpacity(0.12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // 원하는 모서리 반경
                        borderSide: BorderSide.none, // 경계선을 제거
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final nameJwtCubit = context.read<NameJwtCubit>();
                      final List<String> nameJwt = await Account()
                          .login(idController.text, passwordController.text);
                      print('nameJwt: $nameJwt');
                      if (nameJwt[0] == 'login failed') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('아이디 혹은 비밀번호가 틀렸습니다.')),
                        );
                      } else {
                        nameJwtCubit.Login(nameJwt[0], nameJwt[1]);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(currentIndex: 0),
                            ));
                      }
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: loginButtonColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen1(),
                        )),
                    child: Text(
                      '가입하러 가기',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: loginButtonColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
