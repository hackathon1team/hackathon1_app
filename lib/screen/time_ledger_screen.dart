import 'package:flutter/material.dart';
import 'package:memory_app/const/emoji.dart';

class TimeLedgerScreen extends StatefulWidget {
  const TimeLedgerScreen({super.key});

  @override
  State<TimeLedgerScreen> createState() => _TimeLedgerScreenState();
}

class _TimeLedgerScreenState extends State<TimeLedgerScreen> {
  bool writed = true;

  DateTime _selectedDate = DateTime.now();

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

    return Stack(
      children: [
        Positioned(
          top: 80,
          left: 40,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              _selectedDate.month != DateTime.now().month ||
                      _selectedDate.day != DateTime.now().day
                  ? Align(
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
                    )
                  : Container(),
              SizedBox(
                height: 10,
              ),
              Container(
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
                child: DataTable(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        '감정',
                        style: _columnStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '분류',
                        style: _columnStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '내용',
                        style: _columnStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '시간',
                        style: _columnStyle,
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '😲${neutralEmoji['😲']}',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '친구',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '모모 퍼즐 만들기',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '3시간',
                            style: _rowStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '😲${neutralEmoji['😲']}',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '친구',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '모모 퍼즐 만들기',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '3시간',
                            style: _rowStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '😲${neutralEmoji['😲']}',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '친구',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '모모 퍼즐 만들기',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '3시간',
                            style: _rowStyle,
                          ),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '😲${neutralEmoji['😲']}',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '친구',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '모모 퍼즐 만들기',
                            style: _rowStyle,
                          ),
                        ),
                        DataCell(
                          Text(
                            '3시간',
                            style: _rowStyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                    onPressed: () {},
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
