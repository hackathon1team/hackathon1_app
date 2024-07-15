import 'package:flutter/material.dart';
import 'package:memory_app/screen/register_screen3.dart';


import 'components/custom_button.dart';
import 'components/custom_progress_bar.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {

  final TextEditingController nameController = TextEditingController();

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
                  CustomProgressBar(value: 0.25),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '당신의 이름은 무엇인가요?',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: nameController,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: '이름을 작성해주세요',
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
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 40,
              child: CustomButton(text: '이전 질문', right: false, onPressed: () => Navigator.of(context).pop(),),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: CustomButton(text: '다음 질문', right: true, onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen3(),
                  )),),
            ),
          ],

        ),
      ),
    );
  }
}
