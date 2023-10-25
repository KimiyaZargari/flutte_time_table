import 'package:equatable/equatable.dart';

class Slot extends Equatable{
  final int fromTime;
  final String field;

  const Slot({required this.fromTime, required this.field});

  String get sessionString {
    return ' ${fromTime + 1}:00 - $fromTime:00 ';
  }

  @override
  List<Object?> get props => [fromTime, field];



}
