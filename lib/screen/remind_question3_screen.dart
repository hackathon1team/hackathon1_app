import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/screen/components/custom_progress_bar.dart';
import 'package:memory_app/screen/remind_question4_screen.dart';

import '../cubit/meta_question_cubit.dart';
import 'components/custom_button.dart';

class RemindQuestion3Screen extends StatefulWidget {
  final VoidCallback next;
  final VoidCallback previous;
  final String answer3;
  final Function(String) onAnswerChanged;

  const RemindQuestion3Screen({
    super.key,
    required this.next,
    required this.previous,
    required this.answer3,
    required this.onAnswerChanged,
  });

  @override
  State<RemindQuestion3Screen> createState() => _RemindQuestion3ScreenState();
}

class _RemindQuestion3ScreenState extends State<RemindQuestion3Screen> {
  TextEditingController questionController_3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionController_3 = TextEditingController(text: widget.answer3);
    questionController_3.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onAnswerChanged(questionController_3.text);
  }

  @override
  void dispose() {
    questionController_3.removeListener(_onTextChanged);
    questionController_3.dispose();
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
                    '가장 자주 느끼는 감정은 무엇인가요?(3/5)',
                    style: TextStyle(
                        fontSize: 18,
                        color: hintTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomProgressBar(value: 0.6),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: TextFormField(
                      controller: questionController_3,
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
                text: '다음 질문',
                right: true,
                backgroundcolor: Colors.white,
                onPressed: widget.next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
