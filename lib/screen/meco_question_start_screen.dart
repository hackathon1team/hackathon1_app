import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/cubit/meco_question_cubit.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';
import 'package:memory_app/screen/components/custom_button.dart';
import 'package:memory_app/screen/home_screen.dart';
import 'package:memory_app/screen/meco_question_chat_screen.dart';
import 'package:memory_app/screen/meco_question_summary_screen.dart';

class MecoQuestionStartScreen extends StatefulWidget {
  const MecoQuestionStartScreen({super.key});

  @override
  State<MecoQuestionStartScreen> createState() =>
      _MecoQuestionStartScreenState();
}

class _MecoQuestionStartScreenState extends State<MecoQuestionStartScreen> {
  bool isLoading = true;
  bool hasAnswered = false;
  String selectedContent = '';
  List<String> contents = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final nameJwt = BlocProvider.of<NameJwtCubit>(context);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // 질문과 답변 로드
    await context
        .read<MecoQuestionCubit>()
        .loadQuestionAnswer(today, nameJwt.state.nameJwt.jwt!);

    if (mounted) {
      final state = context.read<MecoQuestionCubit>().state;
      if (state is LoadedMecoQuestionCubitState &&
          state.mecoQuestion.answers.isNotEmpty) {
        setState(() {
          hasAnswered = true;
        });
      } else {
        // 콘텐츠 목록 로드
        await _loadContentsList();
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadContentsList() async {
    final nameJwt = BlocProvider.of<NameJwtCubit>(context);
    final cubit = context.read<MecoQuestionCubit>();
    final result = await cubit.loadContents(nameJwt.state.nameJwt.jwt!);
    if (mounted) {
      setState(() {
        contents = result;
        if (contents.isNotEmpty) {
          selectedContent = contents[0];
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      final String selectedDateOnly =
          DateFormat('yyyy-MM-dd').format(pickedDate);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MecoQuestionSummaryScreen(selectedDay: selectedDateOnly),
          ));
    }
  }

  Widget _alreadyAnswered() {
    final cubit = BlocProvider.of<MecoQuestionCubit>(context);
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 5,
          left: 20,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -35,
                  right: -20,
                  child: Image.asset(
                    'assets/components/star.png',
                    scale: 0.6,
                  ),
                ),
                Positioned(
                  top: -15,
                  right: -30,
                  child: Image.asset(
                    'assets/components/star.png',
                    scale: 0.8,
                  ),
                ),
                Center(
                  child: Text(
                    '이미 메코의 질문을 하셨네요.\n메코..! 메코..!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF5A639C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/character/character6.png'),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF5E5B88),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '오늘의 사건: ${cubit.state.mecoQuestion.contents}',
                  style: TextStyle(
                    color: hintTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomButton(
                text: '오늘 대화 보기',
                right: true,
                onPressed: () {
                  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MecoQuestionSummaryScreen(selectedDay: today),
                      ));
                },
                backgroundcolor: Colors.white,
              ),
              SizedBox(height: 10),
              CustomButton(
                text: '이전 대화 보기',
                right: true,
                onPressed: () async => await _selectDate(context),
                backgroundcolor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timeWriteFalse() {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 4,
          left: 40,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '시간 가계부',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '를 작성하지 않으면\n메코가 질문을 할 수 없어요...',
                  style: TextStyle(
                    color: Color(0xFFD4D2D2),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height / 4,
          right: 30,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '먼저 시간가계부를 작성하러 갈까요?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A639C),
                  ),
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: '시간 가계부 가기',
                  right: true,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(currentIndex: 0),
                      ),
                    );
                  },
                  backgroundcolor: Color(0xFF9B86BD).withOpacity(0.41),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: Image.asset('assets/character/character3.png'),
        ),
      ],
    );
  }

  Widget _timeWriteTrue() {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 5,
          left: 20,
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 30, 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -40,
                  right: -30,
                  child: Image.asset(
                    'assets/components/star.png',
                    scale: 0.6,
                  ),
                ),
                Positioned(
                  top: -20,
                  right: -40,
                  child: Image.asset(
                    'assets/components/star.png',
                    scale: 0.8,
                  ),
                ),
                Center(
                  child: Text(
                    '오늘, 가장 인상깊었던\n사건은 무엇인가요?',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF5A639C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/character/character3.png'),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF5E5B88),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedContent,
                    dropdownColor: Color(0xFF5E5B88),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedContent = newValue!;
                      });
                    },
                    items:
                        contents.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomButton(
                text: '대화하러',
                right: true,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MecoQuestionChatScreen(event: selectedContent),
                  ));
                },
                backgroundcolor: Colors.white,
              ),
              SizedBox(height: 10),
              CustomButton(
                text: '이전 대화 보기',
                right: true,
                onPressed: () async => await _selectDate(context),
                backgroundcolor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: hasAnswered
            ? _alreadyAnswered()
            : contents.isEmpty
                ? _timeWriteFalse()
                : _timeWriteTrue(),
      ),
    );
  }
}
