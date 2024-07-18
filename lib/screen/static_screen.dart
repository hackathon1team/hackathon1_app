import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/screen/components/glassmorphism.dart';

class StaticScreen extends StatefulWidget {
  const StaticScreen({super.key});

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  final Map<String, List<double>> mockData1 = {
    '알바': [68, 32],
    '공부': [57, 27],
    '약속': [41, 19],
    '운동': [30, 14],
    '기타': [15, 8]
  };
  final Map<String, double> mockData2 = {
    '긍정': 18,
    '중립': 10,
    '부정': 3,
  };

  final Map<String, double> positiveData = {
    '기쁨': 7,
    '사랑': 3,
    '감사': 1,
    '희망': 2,
    '만족': 5,
    '흥분': 5,
  };

  final Map<String, double> neutralData = {
    '놀람': 3,
    '무관심': 0,
    '혼란': 1,
    '궁금함': 2,
    '생각에 잠김': 1,
    '평온': 3,
  };

  final Map<String, double> negativeData = {
    '슬픔': 3,
    '분노': 1,
    '두려움': 1,
    '혐오': 2,
    '실망': 1,
    '불안': 2,
    '외로움': 2,
    '질투': 3,
    '죄책감': 1,
    '수치심': 1,
  };

  PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_pageController.hasClients && _currentPage < 4) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_pageController.hasClients && _currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget mostTimeChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -10,
                  right: 10,
                  child: Image.asset(
                    'assets/components/star.png',
                    scale: 0.7,
                  ),
                ),
                Center(
                  child: Text(
                    '이번 달 내가 가장 많이\n쓴 시간을 살펴볼까요?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5A639C),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: PieChart(
            PieChartData(
              sections: List.generate(
                mockData1.length,
                (index) {
                  final key = mockData1.keys.elementAt(index);
                  return PieChartSectionData(
                    radius: MediaQuery.of(context).size.width / 4,
                    color: PieChartColor[index],
                    value: mockData1[key]![1],
                    title: '$key\n${mockData1[key]![0].toInt()}시간',
                    titleStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.53),
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              borderData: FlBorderData(show: true),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget lastMonthChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -10,
                  right: 10,
                  child: Image.asset(
                    'assets/components/star.png',
                    // height: 40,
                    // width: 40,
                    scale: 0.7,
                  ),
                ),
                Center(
                  child: Text(
                    '이번 달, 내가 가장 많이\n느낀 감정을 확인해 볼까요?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5A639C),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: List.generate(
                mockData2.length,
                (index) {
                  final key = mockData2.keys.elementAt(index);
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: mockData2[key]!,
                        color: Color(0xFFFFED95),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        width: MediaQuery.of(context).size.width / 8,
                        // 막대 안에 값 표시
                        rodStackItems: [
                          BarChartRodStackItem(
                            0,
                            mockData2[key]!,
                            Colors.transparent,
                            BorderSide.none,
                          ),
                        ],
                      ),
                    ],
                    // 막대 위에 값 표시
                    showingTooltipIndicators: [0],
                  );
                },
              ),
              titlesData: FlTitlesData(
                // y축 타이틀 제거
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                // x축 타이틀 설정 (사용자 지정)
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        mockData2.keys.elementAt(value.toInt()),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              barTouchData: BarTouchData(
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  if (barTouchResponse != null &&
                      barTouchResponse.spot != null &&
                      event.isInterestedForInteractions) {
                    final index = barTouchResponse.spot!.touchedBarGroupIndex;
                    final key = mockData2.keys.elementAt(index);
                    final value = mockData2[key];
                    print('Tapped on $key with value $value');
                    // 여기에 원하는 동작을 추가할 수 있습니다.
                  }
                },
                touchTooltipData: BarTouchTooltipData(
                  fitInsideVertically: true,
                  getTooltipColor: (group) => Colors.transparent,
                  // tooltipPadding: const EdgeInsets.all(0),
                  tooltipMargin: -100,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      '${rod.toY.round().toString()}회',
                      TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/background7.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Glassmorphism(
                  child: mostTimeChart(),
                ),
                Glassmorphism(
                  child: lastMonthChart(),
                ),
                Glassmorphism(
                  child: Container(),
                ),
                Glassmorphism(
                  child: Container(),
                ),
                Glassmorphism(
                  child: Container(),
                ),
              ],
            ),
            if (_currentPage < 4)
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: _nextPage,
                icon: Icon(
                  Icons.keyboard_double_arrow_down,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            if (_currentPage > 0)
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                    onPressed: _previousPage,
                    icon: Icon(
                      Icons.keyboard_double_arrow_up,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
