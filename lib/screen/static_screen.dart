import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_app/const/colors.dart';
import 'package:memory_app/const/emoji.dart';
import 'package:memory_app/cubit/name_jwt_cubit.dart';
import 'package:memory_app/cubit/static_list_cubit.dart';
import 'package:memory_app/model/static_model.dart';
import 'package:memory_app/screen/components/glassmorphism.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StaticScreen extends StatefulWidget {
  const StaticScreen({super.key});

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  @override
  void initState() {
    super.initState();
    loadStatic();
  }

  loadStatic() async {
    final nameJwt = BlocProvider.of<NameJwtCubit>(context);
    await context
        .read<StaticListCubit>()
        .loadStaticList(nameJwt.state.nameJwt.jwt!);
  }

  Widget noData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 70,),
        Text(
          '데이터가 없습니다.\n우리가 더 친해져볼까요?',
          style: TextStyle(
              color: Color(0xFFEAE9E9),
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

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
    return BlocBuilder<StaticListCubit, StaticListCubitState>(
        builder: (context, state) {
      final mostTime = state.staticList.timeSpent;
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
          if (mostTime.isNotEmpty)
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: List.generate(
                    state.staticList.timeSpent.length,
                    (index) {
                      final item = state.staticList.timeSpent[index];
                      return PieChartSectionData(
                        radius: MediaQuery.of(context).size.width / 4,
                        color: PieChartColor[index],
                        value: item.percentage.toDouble(),
                        title: '${item.category}\n${item.hours}시간',
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
          if (mostTime.isEmpty) noData(),
        ],
      );
    });
  }

  Widget lastmonthChart() {
    List<charts.Series<ComparisonWithLastMonth, String>> _createSampleData() {
      final static = BlocProvider.of<StaticListCubit>(context);
      final comparison = static.state.staticList.comparisonWithLastMonth;

      return [
        charts.Series<ComparisonWithLastMonth, String>(
          id: '지난달 비교',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
          domainFn: (ComparisonWithLastMonth month, _) =>
              '${month.previousMonth}월',
          measureFn: (ComparisonWithLastMonth month, _) => month.previousHours,
          data: [comparison],
          labelAccessorFn: (ComparisonWithLastMonth month, _) =>
              '${month.previousCategory} ${month.previousHours}시간',
        ),
        charts.Series<ComparisonWithLastMonth, String>(
          id: '이번달',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
          domainFn: (ComparisonWithLastMonth month, _) =>
              '${month.currentMonth}월',
          measureFn: (ComparisonWithLastMonth month, _) => month.currentHours,
          data: [comparison],
          labelAccessorFn: (ComparisonWithLastMonth month, _) =>
              '${month.currentCategory} ${month.currentHours}시간',
        )
      ];
    }

    return BlocBuilder<StaticListCubit, StaticListCubitState>(
      builder: (context, state) {
        final lastmonth = state.staticList.comparisonWithLastMonth;
        if (state is LoadedStaticListCubitState) {
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
              SizedBox(height: 20),
              if (lastmonth.currentHours != 0)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
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
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                          ),
                          lineStyle: charts.LineStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                    ),
                  ),
                ),
              if (lastmonth.currentHours == 0) noData(),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget mostEmojiChart() {
    return BlocBuilder<StaticListCubit, StaticListCubitState>(
        builder: (context, state) {
      final emoji = state.staticList.emotionsSummary;
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
          if (emoji.isNotEmpty)
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(
                    state.staticList.emotionsSummary.length,
                    (index) {
                      final item = state.staticList.emotionsSummary[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: item.count.toDouble(),
                            color: Color(0xFFFFED95),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            width: MediaQuery.of(context).size.width / 8,
                            // 막대 안에 값 표시
                            rodStackItems: [
                              BarChartRodStackItem(
                                0,
                                item.count.toDouble(),
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
                            state
                                .staticList.emotionsSummary[value.toInt()].type,
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
                        final index =
                            barTouchResponse.spot!.touchedBarGroupIndex;
                        final title =
                            state.staticList.emotionsSummary[index].type;
                        switch (title) {
                          case '긍정':
                            _pageController.jumpToPage(3);
                            break;
                          case '중립':
                            _pageController.jumpToPage(4);
                            break;
                          case '부정':
                            _pageController.jumpToPage(5);
                            break;
                        }
                        // final key = mockData2.keys.elementAt(index);
                        // final value = mockData2[key];
                        // _pageController.jumpToPage(index + 3);
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
          if (emoji.isEmpty) noData(),
        ],
      );
    });
  }

  Widget positiveChart() {
    List<charts.Series<Emotions, String>> _createSampleData() {
      final static = BlocProvider.of<StaticListCubit>(context);

      if (static.state is LoadedStaticListCubitState) {
        final positiveEmotions = (static.state as LoadedStaticListCubitState)
            .staticList
            .positiveEmotions;

        return [
          charts.Series<Emotions, String>(
            id: '긍정적 감정',
            colorFn: (_, __) =>
                charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
            domainFn: (Emotions emotion, _) =>
                '${emotion.emotion}${positiveEmoji[emotion.emotion]}',
            measureFn: (Emotions emotion, _) => emotion.count,
            data: positiveEmotions,
            labelAccessorFn: (Emotions emotion, _) => '${emotion.count}회',
          )
        ];
      }
      return [];
    }

    return BlocBuilder<StaticListCubit, StaticListCubitState>(
      builder: (context, state) {
        final positive = state.staticList.positiveEmotions;
        if (state is LoadedStaticListCubitState) {
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
              if (positive.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
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
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                          ),
                          lineStyle: charts.LineStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                    ),
                  ),
                ),
              if (positive.isEmpty) noData(),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget neutralChart() {
    List<charts.Series<Emotions, String>> _createSampleData() {
      final static = BlocProvider.of<StaticListCubit>(context);

      if (static.state is LoadedStaticListCubitState) {
        final neutralEmotions = (static.state as LoadedStaticListCubitState)
            .staticList
            .neutralEmotions;

        return [
          charts.Series<Emotions, String>(
            id: '중립적 감정',
            colorFn: (_, __) =>
                charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
            domainFn: (Emotions emotion, _) =>
                '${emotion.emotion}${neutralEmoji[emotion.emotion]}',
            measureFn: (Emotions emotion, _) => emotion.count,
            data: neutralEmotions,
            labelAccessorFn: (Emotions emotion, _) => '${emotion.count}회',
          )
        ];
      }
      return [];
    }

    return BlocBuilder<StaticListCubit, StaticListCubitState>(
      builder: (context, state) {
        final neutral = state.staticList.neutralEmotions;
        if (state is LoadedStaticListCubitState) {
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
              if (neutral.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
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
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                          ),
                          lineStyle: charts.LineStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                    ),
                  ),
                ),
              if (neutral.isEmpty) noData(),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget negativeChart() {
    List<charts.Series<Emotions, String>> _createSampleData() {
      final static = BlocProvider.of<StaticListCubit>(context);

      if (static.state is LoadedStaticListCubitState) {
        final negativeEmotions = (static.state as LoadedStaticListCubitState)
            .staticList
            .negativeEmotions;

        return [
          charts.Series<Emotions, String>(
            id: '부정적 감정',
            colorFn: (_, __) =>
                charts.ColorUtil.fromDartColor(Color(0xFFFFE4A2)),
            domainFn: (Emotions emotion, _) =>
                '${emotion.emotion}${negativeEmoji[emotion.emotion]}',
            measureFn: (Emotions emotion, _) => emotion.count,
            data: negativeEmotions,
            labelAccessorFn: (Emotions emotion, _) => '${emotion.count}회',
          )
        ];
      }
      return [];
    }

    return BlocBuilder<StaticListCubit, StaticListCubitState>(
      builder: (context, state) {
        final negative = state.staticList.negativeEmotions;
        if (state is LoadedStaticListCubitState) {
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
              if (negative.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
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
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                      primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                          ),
                          lineStyle: charts.LineStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.transparent),
                            thickness: 0,
                          ),
                        ),
                        showAxisLine: false,
                      ),
                    ),
                  ),
                ),
              if (negative.isEmpty) noData(),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
