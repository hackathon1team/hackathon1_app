import 'package:flutter/material.dart';
import 'package:memory_app/screen/components/app_navigation_bar.dart';

class MecoQuestionSummaryScreen extends StatefulWidget {
  List? chat;
  DateTime selectedDay;

  MecoQuestionSummaryScreen({super.key, this.chat, required this.selectedDay});

  @override
  State<MecoQuestionSummaryScreen> createState() =>
      _MecoQuestionSummaryScreenState();
}

class _MecoQuestionSummaryScreenState extends State<MecoQuestionSummaryScreen> {
  bool writed = false;

  Widget _writeTrue() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.chat!.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Image.asset('assets/character/character5.png');
          }
          if (widget.chat![index - 1]['role'] == 'Meco') {
            if (widget.chat![index - 1]['index'] == 4) {
              return Container();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  widget.chat![index - 1]['text'],
                  style: TextStyle(
                      color: Color(0xFFEDECEC).withOpacity(0.83),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
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
                  widget.chat![index - 1]['text'],
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
      ),
    );
  }

  Widget _writeFalse() {
    return Stack(
      children: [
        Image.asset('assets/character/character5.png'),
        Center(
          child: Column(
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
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {},
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background6.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: writed ? _writeTrue() : _writeFalse(),
      ),
      bottomNavigationBar: AppNavigationBar(currentIndex: 1),
    );
  }
}
