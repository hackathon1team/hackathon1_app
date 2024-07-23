import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_app/const/category.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/const/emoji.dart';

class TimeLedgerScreen extends StatefulWidget {
  const TimeLedgerScreen({super.key});

  @override
  State<TimeLedgerScreen> createState() => _TimeLedgerScreenState();
}

class _TimeLedgerScreenState extends State<TimeLedgerScreen> {
  bool writed = false;
  int? selectedHour;

  DateTime _selectedDate = DateTime.now();
  final boldStyle = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.bold,
    color: Color(0xFF5D659E),
  );

  final normalStyle = TextStyle(
    color: Color(0xFF797FAB),
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  Widget _writeFalse() {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: 40,
          child: Text(
            _selectedDate.month == DateTime.now().month &&
                    _selectedDate.day == DateTime.now().day
                ? '오늘도 하루가 끝났네요.\n${_selectedDate.month.toString()}월 ${_selectedDate.day.toString()}일의 하루를\n기록해 볼까요?'
                : '${_selectedDate.month.toString()}월 ${_selectedDate.day.toString()}일에\n작성한 가계부가 없습니다.',
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '아직 작성한 가계부가 없네요.',
                style: TextStyle(
                  fontSize: 21,
                  color: Color(0xFFD3CBCB),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  '다른 날 데이터 보러가기',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFD9AEAE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  backgroundColor: Color(0xFF8787B7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset('assets/character/character1.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _writeTrue() {
    final TextStyle _columnStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
    final TextStyle _rowStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 80, left: 40),
          child: Text(
            _selectedDate.month == DateTime.now().month &&
                    _selectedDate.day == DateTime.now().day
                ? '오늘도 하루가 끝났네요.\n${_selectedDate.month.toString()}월 ${_selectedDate.day.toString()}일의 하루를\n기록해 볼까요?'
                : '${_selectedDate.month.toString()}월 ${_selectedDate.day.toString()}일 시간 가계부 입니다.',
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            _selectedDate.month != DateTime.now().month ||
                    _selectedDate.day != DateTime.now().day
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDate = DateTime.now();
                          });
                        },
                        child: Text(
                          '오늘로 돌아가기',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFD9AEAE),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: Color(0xFF777DAA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          // 버튼 크기 줄이기
                          minimumSize: Size(0, 36), // 최소 높이 설정
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 300, // 컨테이너의 높이를 고정
                decoration: BoxDecoration(
                  color: Color(0xFFA1A0CA),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(20, 25),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0.0),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                '감정',
                                style: _columnStyle,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                '분류',
                                style: _columnStyle,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                '내용',
                                style: _columnStyle,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                '시간',
                                style: _columnStyle,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${neutralEmoji['놀람']} 놀람',
                                    style: _rowStyle,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '친구',
                                    style: _rowStyle,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '모모 퍼즐 만들기',
                                    style: _rowStyle,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '3시간',
                                    style: _rowStyle,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
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
        child: writed ? _writeTrue() : _writeFalse(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _selectedDate.month == DateTime.now().month &&
                  _selectedDate.day == DateTime.now().day
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Color(0xFFCDCAE2),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Wrap(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(32.0),
                                height: MediaQuery.of(context).size.height *
                                    0.45, // 원하는 높이로 설정 (예: 화면 높이의 60%)
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_selectedDate.month}월 ${_selectedDate.day}일 일정 추가',
                                          style: boldStyle,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(Icons.close),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '감정: ',
                                          style:
                                              boldStyle.copyWith(fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return Wrap(
                                                  children: [
                                                    DefaultTabController(
                                                      length: 3, // 탭의 개수
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: TabBar(
                                                                    tabAlignment:
                                                                        TabAlignment
                                                                            .start,
                                                                    isScrollable:
                                                                        true,
                                                                    indicator:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                              0xFF9B86BD)
                                                                          .withOpacity(
                                                                              0.41),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                    ),
                                                                    indicatorSize:
                                                                        TabBarIndicatorSize
                                                                            .tab,
                                                                    indicatorPadding:
                                                                        EdgeInsets.only(
                                                                            top:
                                                                                3,
                                                                            bottom:
                                                                                0),
                                                                    dividerColor:
                                                                        Colors
                                                                            .transparent,
                                                                    labelColor:
                                                                        Color(
                                                                            0xFF5A639C),
                                                                    labelStyle: boldStyle.copyWith(
                                                                        fontSize:
                                                                            16),
                                                                    unselectedLabelColor:
                                                                        Color(
                                                                            0xFF5A639C),
                                                                    tabs: [
                                                                      Tab(
                                                                          text:
                                                                              '긍정적'),
                                                                      Tab(
                                                                          text:
                                                                              '중립'),
                                                                      Tab(
                                                                          text:
                                                                              '부정적'),
                                                                    ],
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .grey),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: TabBarView(
                                                                children: [
                                                                  // 긍정적 탭의 내용
                                                                  GridView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    gridDelegate:
                                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          3,
                                                                      childAspectRatio:
                                                                          2.5,
                                                                      crossAxisSpacing:
                                                                          8,
                                                                      mainAxisSpacing:
                                                                          8,
                                                                    ),
                                                                    itemCount:
                                                                        positiveEmoji
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return _buildEmojiChip(positiveEmoji
                                                                          .keys
                                                                          .elementAt(
                                                                              index));
                                                                    },
                                                                  ),
                                                                  // 중립 탭의 내용
                                                                  GridView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    gridDelegate:
                                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          3,
                                                                      childAspectRatio:
                                                                          2.5,
                                                                      crossAxisSpacing:
                                                                          8,
                                                                      mainAxisSpacing:
                                                                          8,
                                                                    ),
                                                                    itemCount:
                                                                        neutralEmoji
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return _buildEmojiChip(neutralEmoji
                                                                          .keys
                                                                          .elementAt(
                                                                              index));
                                                                    },
                                                                  ),
                                                                  // 부정적 탭의 내용
                                                                  GridView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    gridDelegate:
                                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                                      crossAxisCount:
                                                                          3,
                                                                      childAspectRatio:
                                                                          2.5,
                                                                      crossAxisSpacing:
                                                                          8,
                                                                      mainAxisSpacing:
                                                                          8,
                                                                    ),
                                                                    itemCount:
                                                                        negativeEmoji
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return _buildEmojiChip(negativeEmoji
                                                                          .keys
                                                                          .elementAt(
                                                                              index));
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            '감정을 선택해주세요',
                                            style: normalStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '분류: ',
                                          style:
                                              boldStyle.copyWith(fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return Wrap(
                                                  children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .close))
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: ListView
                                                                .separated(
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return GestureDetector(
                                                                  onTap: () {},
                                                                  child: Text(
                                                                    category[
                                                                        index],
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          buttonTextColor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      SizedBox(
                                                                height: 15,
                                                              ),
                                                              itemCount:
                                                                  category
                                                                      .length,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            '분류를 선택해주세요',
                                            style: normalStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '내용: ',
                                          style:
                                              boldStyle.copyWith(fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              // Allow the bottom sheet to be fully scrollable
                                              builder: (context) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(
                                                            context)
                                                        .viewInsets
                                                        .bottom, // Adjust padding when the keyboard appears
                                                  ),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon:
                                                              Icon(Icons.close),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    12,
                                                                    0,
                                                                    12,
                                                                    12),
                                                            child:
                                                                TextFormField(
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .top,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                ),
                                                                filled: true,
                                                                fillColor: Color(
                                                                    0xFFA1A0CA),
                                                                hintText:
                                                                    '답변이 어려우면 작성하지 않아도 괜찮아요',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color:
                                                                      hintTextColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              maxLines: null,
                                                              expands: true,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            '추가',
                                                            style: boldStyle
                                                                .copyWith(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: 4,
                                                              horizontal: 24,
                                                            ),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFFDDD9D9),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            minimumSize: Size(0,
                                                                36), // 최소 높이 설정
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            '내용을 작성해주세요',
                                            style: normalStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '시간: ',
                                          style:
                                              boldStyle.copyWith(fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon: Icon(
                                                              Icons.close)),
                                                      Expanded(
                                                        child: CupertinoPicker(
                                                          itemExtent: 40,
                                                          onSelectedItemChanged:
                                                              (int index) {
                                                            setState(() {
                                                              selectedHour =
                                                                  index + 1;
                                                            });
                                                          },
                                                          children: List<
                                                                  Widget>.generate(
                                                              24, (int index) {
                                                            return Center(
                                                              child: Text(
                                                                '${index + 1}시간',
                                                                style: boldStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          '추가',
                                                          style: boldStyle
                                                              .copyWith(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      24),
                                                          backgroundColor:
                                                              Color(0xFFDDD9D9),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          // 버튼 크기 줄이기
                                                          minimumSize: Size(0,
                                                              36), // 최소 높이 설정
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            '소요시간을 작성해주세요(시간당)',
                                            style: normalStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '추가',
                                            style: boldStyle.copyWith(
                                              fontSize: 17,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 24),
                                            backgroundColor: Color(0xFFDDD9D9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            // 버튼 크기 줄이기
                                            minimumSize:
                                                Size(0, 36), // 최소 높이 설정
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    child: Icon(Icons.add_outlined),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Color(0xFFFFE9E9), width: 5),
            ),
            child: FloatingActionButton(
              onPressed: () => _selectDate(context),
              backgroundColor: Colors.transparent,
              foregroundColor: Color(0xFFFFE9E9),
              elevation: 0,
              child: Icon(Icons.date_range_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildEmojiChip(String label) {
  return GestureDetector(
    onTap: () {},
    child: Chip(
      label: Text(
        '${Emoji[label]} $label',
        style: TextStyle(
          color: buttonTextColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: buttonTextColor.withOpacity(0.5),
          width: 1,
        ),
      ),
    ),
  );
}
