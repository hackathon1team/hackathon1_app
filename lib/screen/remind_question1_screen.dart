import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/cubit/meta_question_cubit.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';
import 'package:memory_app/screen/components/custom_progress_bar.dart';

import 'components/custom_button.dart';

class RemindQuestion1Screen extends StatefulWidget {
  final VoidCallback next;
  final String answer1;
  final bool register;
  final Function(String) onAnswerChanged;

  const RemindQuestion1Screen({super.key, required this.next, required this.answer1, required this.onAnswerChanged, required this.register});

  @override
  State<RemindQuestion1Screen> createState() => _RemindQuestion1ScreenState();
}

class _RemindQuestion1ScreenState extends State<RemindQuestion1Screen> {
  TextEditingController questionController_1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionController_1 = TextEditingController(text: widget.answer1);
    questionController_1.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onAnswerChanged(questionController_1.text);
  }

  @override
  void dispose() {
    questionController_1.removeListener(_onTextChanged);
    questionController_1.dispose();
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
                    '자신의 장점과 단점은 무엇인가요?(1/5)',
                    style: TextStyle(
                        fontSize: 18,
                        color: hintTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomProgressBar(value: 0.2),
                  SizedBox(height: 20,),
                  Container(
                    height: 200,
                    child: TextFormField(
                      controller: questionController_1,
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
            if(widget.register)
            Positioned(
              bottom: 40,
              left: 40,
              child: CustomButton(
                text: '이전 질문',
                right: false,backgroundcolor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: CustomButton(
                text: '다음 질문',
                right: true,backgroundcolor: Colors.white,
                onPressed: widget.next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
