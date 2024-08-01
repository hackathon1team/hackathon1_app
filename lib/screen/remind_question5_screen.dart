import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/cubit/meta_question_cubit.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';
import 'package:memory_app/screen/components/custom_progress_bar.dart';

import 'components/custom_button.dart';
import 'home_screen.dart';

class RemindQuestion5Screen extends StatefulWidget {
  final VoidCallback previous;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String answer5;
  final Function(String) onAnswerChanged;

  const RemindQuestion5Screen(
      {super.key,
      required this.previous,
      required this.answer1,
      required this.answer2,
      required this.answer3,
      required this.answer4,
      required this.answer5,
      required this.onAnswerChanged});

  @override
  State<RemindQuestion5Screen> createState() => _RemindQuestion5ScreenState();
}

class _RemindQuestion5ScreenState extends State<RemindQuestion5Screen> {
  TextEditingController questionController_5 = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionController_5 = TextEditingController(text: widget.answer5);
    questionController_5.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onAnswerChanged(questionController_5.text);
  }

  @override
  void dispose() {
    questionController_5.removeListener(_onTextChanged);
    questionController_5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '자신에 대해서\n얼마나 알고 있나요?',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '자신의 정체성은 무엇인가요?(5/5)',
                    style: TextStyle(
                        fontSize: 18,
                        color: hintTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomProgressBar(value: 1.0),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: TextFormField(
                      controller: questionController_5,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFF665E8A),
                        hintText: '답변이 어려우면 작성하지 않아도 괜찮아요\n언제든 다시 작성이 가능합니다',
                        hintStyle: TextStyle(
                          color: hintTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      maxLines: null,
                      expands: true,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
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
                onPressed: widget.previous,
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: CustomButton(
                text: '제출하기',
                right: true,
                backgroundcolor: Colors.white,
                onPressed: () async {
                  final nameJwt = BlocProvider.of<NameJwtCubit>(context);
                  await context.read<MetaQuestionCubit>().answerQuestion(
                    [
                      widget.answer1,
                      widget.answer2,
                      widget.answer3,
                      widget.answer4,
                      questionController_5.text
                    ],
                    nameJwt.state.nameJwt.jwt!,
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          currentIndex: 0,
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
