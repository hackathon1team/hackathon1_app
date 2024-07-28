import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/cubit/meco_question_cubit.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';
import 'package:memory_app/screen/components/app_navigation_bar.dart';

class MecoQuestionSummaryScreen extends StatefulWidget {
  String selectedDay;

  MecoQuestionSummaryScreen({super.key, required this.selectedDay});

  @override
  State<MecoQuestionSummaryScreen> createState() =>
      _MecoQuestionSummaryScreenState();
}

class _MecoQuestionSummaryScreenState extends State<MecoQuestionSummaryScreen> {

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.parse(widget.selectedDay);
    _loadQuestionAnswer();
  }

  _loadQuestionAnswer() async{
    final nameJwt = BlocProvider.of<NameJwtCubit>(context);
    await context
        .read<MecoQuestionCubit>()
        .loadQuestionAnswer(widget.selectedDay, nameJwt.state.nameJwt.jwt!);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.selectedDay = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      await _loadQuestionAnswer();
    }
  }

  Widget _writeTrue(MecoQuestionCubitState state) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Image.asset('assets/character/character4.png');
        } else if (index == 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '오늘의 인상깊은 사건은 무엇인가요?',
              style: TextStyle(
                  color: Color(0xFFEDECEC).withOpacity(0.83),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else if (index == 2) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                state.mecoQuestion.contents!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEDECEC).withOpacity(0.83),
                ),
              ),
            ),
          );
        } else if (index == 9){
          return Center(
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                '다른 날 보러가기',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFD9AEAE),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDDD9D9).withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        }else if (index % 2 == 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              state.mecoQuestion.questions[(index - 3) ~/ 2],
              style: TextStyle(
                  color: Color(0xFFEDECEC).withOpacity(0.83),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                state.mecoQuestion.answers[(index - 3) ~/ 2],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEDECEC).withOpacity(0.83),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _writeFalse() {
    return Column(
      children: [
        Image.asset('assets/character/character4.png'),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '조회한 날의 메코와\n대화가 존재하지 않습니다.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4D2D2),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                '다른 날 보러가기',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFD9AEAE),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Color(0xFFDDD9D9).withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MecoQuestionCubit, MecoQuestionCubitState>(
          builder: (context, state) {
        if(state is ErrorMecoQuestionCubitState){
          return Center(child: Text(state.errorMessage),);
        }
        if(state is LoadedMecoQuestionCubitState || state is LoadingMecoQuestionCubitState){
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/background6.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: state.mecoQuestion.answers.isNotEmpty
                ? _writeTrue(state)
                : Padding(
              padding: EdgeInsets.all(20),
              child: _writeFalse(),
            ),
          );
        }
        return Container();
      }),
      bottomNavigationBar: AppNavigationBar(currentIndex: 1),
    );
  }
}
