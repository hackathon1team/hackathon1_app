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
                  CustomProgressBar(value: 0.5),
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
                            errorText: duplicated == null
                                ? null
                                : duplicated!
                                    ? '사용할 수 없는 아이디입니다.'
                                    : '사용 가능한 아이디입니다.',
                            errorStyle: duplicated == null
                                ? null
                                : TextStyle(
                                    color: duplicated!
                                        ? Color(0xFFC23737).withOpacity(0.9)
                                        : Color(0xFF7FC057).withOpacity(0.9),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                            hintText: '아이디 최대 10글자',
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
                        onPressed: () async {
                          final isDuplicated = await Account().checkDuplicated(idController.text);
                          print('중복확인: $isDuplicated');
                          setState(() {
                            duplicated = isDuplicated;
                          });
                        },
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
                onPressed: () {
                  if(duplicated == false){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen4(
                            name: widget.name,
                            id: idController.text,
                          ),
                        ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
