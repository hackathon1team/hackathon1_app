import 'package:equatable/equatable.dart';
import 'package:memory_app/model/static_model.dart';

class StaticListModel extends Equatable {
  final List<TimeSpent> timeSpent;
  final ComparisonWithLastMonth comparisonWithLastMonth;
  final List<EmotionsSummary> emotionsSummary;
  final List<Emotions> positiveEmotions;
  final List<Emotions> neutralEmotions;
  final List<Emotions> negativeEmotions;

  StaticListModel.init()
      : this(
          timeSpent: [],
          comparisonWithLastMonth: ComparisonWithLastMonth.init(),
          emotionsSummary: [],
          positiveEmotions: [],
          neutralEmotions: [],
          negativeEmotions: [],
        );

  StaticListModel({
    required this.timeSpent,
    required this.comparisonWithLastMonth,
    required this.emotionsSummary,
    required this.positiveEmotions,
    required this.neutralEmotions,
    required this.negativeEmotions,
  });

  @override
  List<Object?> get props => [
        timeSpent,
        comparisonWithLastMonth,
        emotionsSummary,
        positiveEmotions,
        neutralEmotions,
        negativeEmotions,
      ];
}
