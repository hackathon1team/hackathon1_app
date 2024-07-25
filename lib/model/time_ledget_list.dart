import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:memory_app/model/time_ledger.dart';

class TimeLedgerList extends Equatable {
  List<TimeLedger> timeLedgerList;
  String date;
  TimeLedgerList({required this.timeLedgerList, required this.date});


  TimeLedgerList.init() : this(date: '', timeLedgerList: []);

  @override
  List<Object?> get props => [timeLedgerList];
}
