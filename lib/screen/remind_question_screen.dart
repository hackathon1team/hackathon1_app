import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/meta_question_cubit.dart';
import '../cubit/name_jwt_cubit.dart';
import 'remind_question1_screen.dart';
import 'remind_question2_screen.dart';
import 'remind_question3_screen.dart';
import 'remind_question4_screen.dart';
import 'remind_question5_screen.dart';

class RemindQuestionScreen extends StatefulWidget {
  int currentIndex;
  final bool register;

  RemindQuestionScreen({super.key, required this.currentIndex, required this.register});

  @override
  State<RemindQuestionScreen> createState() => _RemindQuestionScreenState();
}

class _RemindQuestionScreenState extends State<RemindQuestionScreen> {
  late String answer1;
  late String answer2;
  late String answer3;
  late String answer4;
  late String answer5;


  void loadQuestionAnswer() async {
    final nameJwt = BlocProvider.of<NameJwtCubit>(context);
    await context
        .read<MetaQuestionCubit>()
        .loadQuestionAnswer(nameJwt.state.nameJwt.jwt!);
    final meta = BlocProvider.of<MetaQuestionCubit>(context);
    print(
        '답변: ${meta.state.metaQuestion.answer1}, ${meta.state.metaQuestion.answer2}, ${meta.state.metaQuestion.answer3}, ${meta.state.metaQuestion.answer4}, ${meta.state.metaQuestion.answer5},');
    answer1 = meta.state.metaQuestion.answer1;
    answer2 = meta.state.metaQuestion.answer2;
    answer3 = meta.state.metaQuestion.answer3;
    answer4 = meta.state.metaQuestion.answer4;
    answer5 = meta.state.metaQuestion.answer5;
  }

  void onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  void updateAnswer(int questionNumber, String newAnswer) {
    setState(() {
      switch (questionNumber) {
        case 1:
          answer1 = newAnswer;
          break;
        case 2:
          answer2 = newAnswer;
          break;
        case 3:
          answer3 = newAnswer;
          break;
        case 4:
          answer4 = newAnswer;
          break;
        case 5:
          answer5 = newAnswer;
          break;
      }
    });
  }

  List<Widget> _widgetOptions() {
    return [
      RemindQuestion1Screen(
        next: () => onItemTapped(1),
        answer1: answer1,
        onAnswerChanged: (newAnswer) => updateAnswer(1, newAnswer),
        register: widget.register,
      ),
      RemindQuestion2Screen(
        next: () => onItemTapped(2),
        previous: () => onItemTapped(0),
        answer2: answer2,
        onAnswerChanged: (newAnswer) => updateAnswer(2, newAnswer),
      ),
      RemindQuestion3Screen(
        next: () => onItemTapped(3),
        previous: () => onItemTapped(1),
        answer3: answer3,
        onAnswerChanged: (newAnswer) => updateAnswer(3, newAnswer),
      ),
      RemindQuestion4Screen(
        next: () => onItemTapped(4),
        previous: () => onItemTapped(2),
        answer4: answer4,
        onAnswerChanged: (newAnswer) => updateAnswer(4, newAnswer),
      ),
      RemindQuestion5Screen(
        previous: () => onItemTapped(3),
        answer1: answer1,
        answer2: answer2,
        answer3: answer3,
        answer4: answer4,
        answer5: answer5,
        onAnswerChanged: (newAnswer) => updateAnswer(5, newAnswer),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetaQuestionCubit, MetaQuestionCubitState>(
      builder: (context, state) {
        print('현재 상재: $state');
        if (state is InitMetaQuestionCubitState) {
          loadQuestionAnswer();
        } else if (state is LoadingMetaQuestionCubitState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorMetaQuestionCubitState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is LoadedMetaQuestionCubitState) {
          return _widgetOptions().elementAt(widget.currentIndex);
        }
        return Container();
      },
    );
  }
}
