import 'package:equatable/equatable.dart';

class StaticEmoji {
  final String emoji;
  final int value;

  StaticEmoji(this.emoji, this.value);
}

class StaticMonth {
  final int month;
  final String content;
  final int value;

  StaticMonth(this.month, this.content, this.value);
}

class TimeSpent extends Equatable{
  final String category;
  final int hours;
  final int percentage;

  TimeSpent.init() : this(category: '', hours: 0, percentage: 0);

  TimeSpent({
    required this.category,
    required this.hours,
    required this.percentage,
  });

  @override

  List<Object?> get props => [category, hours, percentage];
}

class ComparisonWithLastMonth extends Equatable{
  final String previousCategory;
  final String previousMonth;
  final double previousHours;
  final String currentCategory;
  final String currentMonth;
  final double currentHours;

  ComparisonWithLastMonth.init()
      : this(
            currentCategory: '',
            currentHours: 0,
            currentMonth: '',
            previousCategory: '',
            previousHours: 0,
            previousMonth: '');

  ComparisonWithLastMonth(
      {required this.previousCategory,
      required this.previousMonth,
      required this.previousHours,
      required this.currentCategory,
      required this.currentMonth,
      required this.currentHours});

  @override
  List<Object?> get props => [previousCategory, previousMonth, previousHours, currentCategory, currentMonth, currentHours];
}

class EmotionsSummary extends Equatable{
  final String type;
  final int count;

  EmotionsSummary.init() : this(type: '', count: 0);

  EmotionsSummary({required this.type, required this.count});

  @override
  List<Object?> get props => [type, count];
}

class Emotions extends Equatable{
  final String emotion;
  final int count;

  Emotions.init(): this(emotion: '', count: 0);

  Emotions({required this.emotion, required this.count});

  @override
  List<Object?> get props => [emotion, count];
}
