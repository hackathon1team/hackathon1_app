import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/account/account.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';

import '../const/colors.dart';
import 'components/custom_button.dart';
import 'components/custom_progress_bar.dart';
import 'components/glassmorphism.dart';
import 'meta_explain_screen.dart';

class RegisterScreen4 extends StatefulWidget {
  final String name;
  final String id;

  const RegisterScreen4({super.key, required this.name, required this.id});

  @override
  State<RegisterScreen4> createState() => _RegisterScreen4State();
}

class _RegisterScreen4State extends State<RegisterScreen4> {
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;
  String? errorText;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validateInput);
  }

  @override
  void dispose() {
    passwordController.removeListener(_validateInput);
    passwordController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      if (passwordController.text.length < 4 || passwordController.text.length > 20) {
        errorText = '4글자 이상 20글자 이하로 입력해주세요.';
        isValid = false;
      } else {
        errorText = null;
        isValid = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomProgressBar(value: 1.0),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '사용할 비밀번호를 작성해주세요',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '비밀번호 4-20글자',
                      hintStyle: TextStyle(
                        color: Color(0xFFE7E7E7),
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      errorText: errorText,
                      errorStyle: TextStyle(
                        color: Color(0xFFC23737).withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    obscureText: obscure,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 40,
              child: CustomButton(
                text: '이전 질문',
                right: false,
                backgroundcolor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: CustomButton(
                text: '가입하기',
                right: true,
                backgroundcolor: Colors.white,
                onPressed: isValid ? () async {
                  final nameJwtCubit = context.read<NameJwtCubit>();
                  final int signupStatus = await Account()
                      .signup(widget.name, widget.id, passwordController.text);
                  if (signupStatus == 200) {
                    final List<String> nameJwt = await Account()
                        .login(widget.id, passwordController.text);
                    nameJwtCubit.Login(nameJwt[0], nameJwt[1]);

                    showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0),
                      context: context,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Glassmorphism(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '회원가입 성공',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Image.asset('assets/character/character2.png'),
                                Text(
                                  '이제,메코와 함께',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  '나에 대해 알아보아요.',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MetaExplainScreen(),
                                      )),
                                  child: Text(
                                    '시작하기',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: buttonTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
