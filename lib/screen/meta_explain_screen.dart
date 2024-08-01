import 'package:flutter/material.dart';
import 'package:memory_app/screen/register_screen4.dart';
import 'package:memory_app/screen/remind_question_screen.dart';


import 'components/custom_button.dart';
import 'remind_question1_screen.dart';

class MetaExplainScreen extends StatefulWidget {
  const MetaExplainScreen({super.key});

  @override
  State<MetaExplainScreen> createState() => _MetaExplainScreenState();
}

class _MetaExplainScreenState extends State<MetaExplainScreen> {

  double _opacity1 = 0.0;
  double _opacity2 = 0.0;
  double _opacity3 = 0.0;
  double _opacity4 = 0.0;
  double _opacity5 = 0.0;
  double _opacity6 = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() => _opacity1 = 1.0);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _opacity2 = 1.0);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _opacity3 = 1.0);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _opacity4 = 1.0);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _opacity5 = 1.0);
    await Future.delayed(Duration(seconds: 1));
    setState(() => _opacity6 = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background4.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 104,
              top: 193,
              child: SizedBox(
                width: 173,
                height: 101,
                child: AnimatedOpacity(
                  opacity: _opacity1,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    '메타인지란?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 85,
              top: 335,
              child: SizedBox(
                width: 112,
                height: 120,
                child: AnimatedOpacity(
                  opacity: _opacity2,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    '자기 인식',
                    style: TextStyle(
                      color: Color(0xD3ECECEC),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 217,
              top: 386,
              child: SizedBox(
                width: 105,
                height: 120,
                child: AnimatedOpacity(
                  opacity: _opacity3,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    '자기 평가',
                    style: TextStyle(
                      color: Color(0xD3ECECEC),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 104,
              top: 437,
              child: SizedBox(
                width: 105,
                height: 120,
                child: AnimatedOpacity(
                  opacity: _opacity4,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    '계획',
                    style: TextStyle(
                      color: Color(0xD3ECECEC),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 34,
              top: 576,
              child: SizedBox(
                width: 335,
                child: AnimatedOpacity(
                  opacity: _opacity5,
                  duration: Duration(milliseconds: 500),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '메타인지',
                          style: TextStyle(
                            color: Color(0xFF444B77),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text:
                              '는 자기 자신의 사고 과정에 대해 \n생각하는 능력을 의미합니다. \n즉, 자신의 생각, 학습, 이해, 기억 등을 \n인식하고 조절하는 능력입니다.',
                          style: TextStyle(
                            color: Color(0xD3ECECEC),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: AnimatedOpacity(
                opacity: _opacity6,
                duration: Duration(milliseconds: 500),
                child: CustomButton(
                  text: '질문 대답 하러가기',
                  right: true,
                  backgroundcolor: Colors.white,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RemindQuestionScreen(currentIndex: 0, register: true,),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
