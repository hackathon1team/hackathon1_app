import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_app/screen/register_screen1.dart';


import '../const/colors.dart';
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
        child: Glassmorphism(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Image.asset('assets/character/character1.png'),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
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
                  onPressed: () {},
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
    );
  }
}
