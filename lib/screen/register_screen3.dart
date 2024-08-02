import 'package:flutter/material.dart';
import 'package:memory_app/account/account.dart';
import 'package:memory_app/screen/register_screen4.dart';

import 'components/custom_button.dart';
import 'components/custom_progress_bar.dart';

class RegisterScreen3 extends StatefulWidget {
  final String name;

  const RegisterScreen3({super.key, required this.name});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final TextEditingController idController = TextEditingController();
  bool? duplicated;
  String? errorText;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    idController.addListener(_validateInput);
  }

  @override
  void dispose() {
    idController.removeListener(_validateInput);
    idController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      if (idController.text.length < 4 || idController.text.length > 20) {
        errorText = '4글자 이상 20글자 이하로 입력해주세요.';
        isValid = false;
      } else {
        errorText = null;
        isValid = true;
      }
      // 텍스트가 변경되면 중복 확인 상태를 초기화합니다.
      duplicated = null;
    });
  }

  void _checkDuplicate() async {
    if (isValid) {
      final isDuplicated = await Account().checkDuplicated(idController.text);
      setState(() {
        duplicated = isDuplicated;
        if (isDuplicated) {
          errorText = '사용할 수 없는 아이디입니다.';
          isValid = false;
        } else {
          errorText = '사용 가능한 아이디입니다.';
          isValid = true;
        }
      });
    }
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
                  CustomProgressBar(value: 0.66),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '사용할 아이디를 작성해주세요',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: idController,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            errorText: errorText,
                            errorStyle: TextStyle(
                              color: errorText == '사용 가능한 아이디입니다.'
                                  ? Color(0xFF7FC057).withOpacity(0.9)
                                  : Color(0xFFC23737).withOpacity(0.9),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            hintText: '아이디 4-20글자',
                            hintStyle: TextStyle(
                              color: Color(0xFFE7E7E7),
                              fontSize: 22,
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
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: duplicated == null
                                    ? Colors.white
                                    : duplicated!
                                        ? Color(0xFFC23737).withOpacity(0.9)
                                        : Color(0xFF7FC057).withOpacity(0.9),
                                width: 1.0,
                              ),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: duplicated == null
                                    ? Colors.white
                                    : duplicated!
                                        ? Color(0xFFC23737).withOpacity(0.9)
                                        : Color(0xFF7FC057).withOpacity(0.9),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: isValid ? _checkDuplicate : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          backgroundColor: Color(0xFF676491),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '중복 확인',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
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
                text: '다음 질문',
                right: true,
                backgroundcolor: Colors.white,
                onPressed: isValid && duplicated == false
                    ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen4(
                        name: widget.name,
                        id: idController.text,
                      ),
                    ))
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
