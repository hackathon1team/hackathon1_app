import 'package:flutter/material.dart';
import 'package:memory_app/screen/meco_question_summary_screen.dart';

import '../const/colors.dart';
import 'components/app_navigation_bar.dart';

class ChatScreen extends StatefulWidget {
  final String event;

  const ChatScreen({
    super.key,
    required this.event,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool loading = false;
  List textChat = [];
  String name = '태기';
  int currentIndex = 1;

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    fromText(query: widget.event, index: -1);
  }

  // Text only input
  void fromText({required String query, required int index}) {
    List question = [
      '오늘의 인상깊은 사건은 무엇인가요?',
      '이 사건에 대한 감정은 무엇이고 원인은 무엇인가요?',
      '이 감정을 어떻게 표현했어요?',
      '이 상황을 통해 무엇을 배울 수 있을까요?',
      '그렇군요. $name님 오늘 하루도 고생 많으셨어요 !',
    ];

    if (index == -1) {
      setState(() {
        textChat.add({
          "role": 'Meco',
          'index': index + 1,
          "text": question[index + 1],
        });
      });
      setState(() {
        textChat.add({
          "role": name,
          'index': index + 1,
          "text": query,
        });
      });

      setState(() {
        textChat.add({
          "role": 'Meco',
          'index': index + 2,
          "text": question[index + 2],
        });
      });
    } else {
      setState(() {
        loading = true;
        textChat.add({
          "role": name,
          'index': index,
          "text": query,
        });
        _textController.clear();
      });

      setState(() {
        loading = false;
        textChat.add({
          "role": 'Meco',
          'index': index + 1,
          "text": question[index + 1],
        });
      });
    }
    scrollToTheEnd();
  }

  void scrollToTheEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: textChat.length + 1,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                        top: 80,
                      ),
                      child: Text(
                        '오늘도 고생했어요\n메코는 $name님한테\n궁금한게 많아요',
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    );
                  }
                  index -= 1;
                  if (textChat[index]['role'] == 'Meco') {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3 * 2,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -5,
                                  right: 10,
                                  child: Image.asset(
                                    'assets/components/star.png',
                                    // scale: 0.9,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    textChat[index]['text'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF5A639C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width / 3 * 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                textChat[index]["text"],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF5A639C),
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            if (currentIndex < 4)
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 200,
                      child: TextFormField(
                        controller: _textController,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.25),
                          // Color(0xFF665E8A),
                          hintText:
                              '메코한테는 솔직한 답변을 해주세요.\n답변을 하기 어렵다면 아무것도 입력하지말고\n\'보내기\'를 눌러주세요.',
                          hintStyle: TextStyle(
                            color: hintTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        expands: true,
                        maxLines: null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 30,
                    child: GestureDetector(
                      onTap: () {
                        fromText(
                            query: _textController.text,
                            index: currentIndex);
                        setState(() {
                          currentIndex += 1;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.25),
                        ),
                        child: Text(
                          '보내기',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (currentIndex == 4)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MecoQuestionSummaryScreen(chat: textChat, selectedDay: DateTime.now(),),
                      ));
                },
                child: Text(
                  '오늘의 답변 확인하기',
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
      ),
      bottomNavigationBar: AppNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}
