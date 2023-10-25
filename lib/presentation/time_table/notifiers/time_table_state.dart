part of 'time_table.dart';

@freezed
class TimeTableState with _$TimeTableState {
  factory TimeTableState.initial() = _Initial;

  factory TimeTableState.loaded() = _Loaded;

  factory TimeTableState.selecting(List<Slot> selectedItems) =
      _Selecting;
}
