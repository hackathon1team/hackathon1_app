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

class TimeSpent {
  final String category;
  final int hours;
  final int percentage;

  TimeSpent(
      {required this.category, required this.hours, required this.percentage});
}

class ComparisonWithLastMonth {
  final String previousCategory;
  final String previousMonth;
  final int previousHours;
  final String currentCategory;
  final String currentMonth;
  final int currentHours;

  ComparisonWithLastMonth(
      {required this.previousCategory,
      required this.previousMonth,
      required this.previousHours,
      required this.currentCategory,
      required this.currentMonth,
      required this.currentHours});
}

class EmotionsSummary {
  final String type;
  final int count;

  EmotionsSummary({required this.type, required this.count});
}

class Emotions {
  final String emotion;
  final int count;

  Emotions({required this.emotion, required this.count});
}
