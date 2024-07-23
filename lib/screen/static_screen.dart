import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/const/emoji.dart';
import 'package:memory_app/model/static_model.dart';
import 'package:memory_app/screen/components/glassmorphism.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

  Widget lastmonthChart() {
    List<charts.Series<StaticMonth, String>> _createSampleData() {
      final data = [
        StaticMonth(7, '알바', 57),
        StaticMonth(8, '공부', 62),
      ];

      return [
        charts.Series<StaticMonth, String>(
          id: '지난달 비교',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
          domainFn: (StaticMonth month, _) => '${month.month}월',
          measureFn: (StaticMonth month, _) => month.value,
          data: data,
          labelAccessorFn: (StaticMonth month, _) =>
              '${month.content} ${month.value}시간',
        )
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                    '지난달과 비교하여\n시간을 한눈에 확인해 볼까요?',
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
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: charts.BarChart(
              _createSampleData(),
              animate: true,
              vertical: false,
              defaultRenderer: charts.BarRendererConfig(
                cornerStrategy: const charts.ConstCornerStrategy(30),
                maxBarWidthPx: 50,
                barRendererDecorator: charts.BarLabelDecorator<String>(
                  insideLabelStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.black,
                  ),
                ),
              ),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.white),
                    fontSize: 14,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // domain axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Colors.transparent), // Label을 숨깁니다.
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // primaryMeasure axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mostEmojiChart() {
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
        SizedBox(
          height: 20,
        ),
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
                    // final key = mockData2.keys.elementAt(index);
                    // final value = mockData2[key];
                    _pageController.jumpToPage(index + 3);
                    // _pageController.animateToPage(index + 2,
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.easeInOut);
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

  Widget positiveChart() {
    List<charts.Series<StaticEmoji, String>> _createSampleData() {
      final data = [
        StaticEmoji('기쁨', 7),
        StaticEmoji('사랑', 3),
        StaticEmoji('감사', 1),
        StaticEmoji('희망', 2),
        StaticEmoji('만족', 5),
        StaticEmoji('흥분', 5),
      ];

      return [
        charts.Series<StaticEmoji, String>(
          id: '긍정적 감정',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
          domainFn: (StaticEmoji emoji, _) =>
              '${emoji.emoji}${positiveEmoji[emoji.emoji]}',
          measureFn: (StaticEmoji emoji, _) => emoji.value,
          data: data,
          labelAccessorFn: (StaticEmoji emotion, _) => '${emotion.value}회',
        )
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                    '긍정적 감정',
                    style: TextStyle(
                      fontSize: 20,
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
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: charts.BarChart(
              _createSampleData(),
              animate: true,
              vertical: false,
              defaultRenderer: charts.BarRendererConfig(
                cornerStrategy: const charts.ConstCornerStrategy(30),
                barRendererDecorator: charts.BarLabelDecorator<String>(
                  insideLabelStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.black,
                  ),
                ),
              ),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.white),
                    fontSize: 14,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // domain axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Colors.transparent), // Label을 숨깁니다.
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // primaryMeasure axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget neutralChart() {
    List<charts.Series<StaticEmoji, String>> _createSampleData() {
      final data = [
        StaticEmoji('놀람', 3),
        StaticEmoji('무관심', 0),
        StaticEmoji('혼란', 1),
        StaticEmoji('궁금함', 2),
        StaticEmoji('생각에 잠김', 1),
        StaticEmoji('평온', 3),
      ];

      return [
        charts.Series<StaticEmoji, String>(
          id: '중립적 감정',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
          domainFn: (StaticEmoji emoji, _) =>
              '${emoji.emoji}${neutralEmoji[emoji.emoji]}',
          measureFn: (StaticEmoji emoji, _) => emoji.value,
          data: data,
          labelAccessorFn: (StaticEmoji emotion, _) => '${emotion.value}회',
        )
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                    '중립적 감정',
                    style: TextStyle(
                      fontSize: 20,
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
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: charts.BarChart(
              _createSampleData(),
              animate: true,
              vertical: false,
              defaultRenderer: charts.BarRendererConfig(
                cornerStrategy: const charts.ConstCornerStrategy(30),
                barRendererDecorator: charts.BarLabelDecorator<String>(
                  insideLabelStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.black,
                  ),
                ),
              ),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.white),
                    fontSize: 14,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // domain axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Colors.transparent), // Label을 숨깁니다.
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // primaryMeasure axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget negativeChart() {
    List<charts.Series<StaticEmoji, String>> _createSampleData() {
      final data = [
        StaticEmoji('슬픔', 3),
        StaticEmoji('분노', 1),
        StaticEmoji('두려움', 1),
        StaticEmoji('혐오', 2),
        StaticEmoji('실망', 1),
        StaticEmoji('불안', 2),
        StaticEmoji('외로움', 2),
        StaticEmoji('질투', 3),
        StaticEmoji('죄책감', 1),
        StaticEmoji('수치심', 1),
      ];

      return [
        charts.Series<StaticEmoji, String>(
          id: '부정적 감정',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
          domainFn: (StaticEmoji emoji, _) =>
              '${emoji.emoji}${negativeEmoji[emoji.emoji]}',
          measureFn: (StaticEmoji emoji, _) => emoji.value,
          data: data,
          labelAccessorFn: (StaticEmoji emotion, _) => '${emotion.value}회',
        )
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                    '부정적 감정',
                    style: TextStyle(
                      fontSize: 20,
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
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: charts.BarChart(
              _createSampleData(),
              animate: true,
              vertical: false,
              defaultRenderer: charts.BarRendererConfig(
                cornerStrategy: const charts.ConstCornerStrategy(30),
                barRendererDecorator: charts.BarLabelDecorator<String>(
                  insideLabelStyleSpec: charts.TextStyleSpec(
                    color: charts.MaterialPalette.black,
                  ),
                ),
              ),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.white),
                    fontSize: 14,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // domain axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
              ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    color: charts.ColorUtil.fromDartColor(
                        Colors.transparent), // Label을 숨깁니다.
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.ColorUtil.fromDartColor(Colors.transparent),
                    thickness: 0, // primaryMeasure axis 기준선 제거
                  ),
                ),
                showAxisLine: false,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Glassmorphism(
                    child: mostTimeChart(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Glassmorphism(
                    child: lastmonthChart(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Glassmorphism(
                    child: mostEmojiChart(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Glassmorphism(
                    child: positiveChart(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Glassmorphism(
                    child: neutralChart(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Glassmorphism(
                    child: negativeChart(),
                  ),
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


