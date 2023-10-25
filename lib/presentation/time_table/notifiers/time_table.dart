import 'package:riverpod/riverpod.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/time_table/slot.dart';

part 'time_table.freezed.dart';

part 'time_table_state.dart';

final timeTableNotifierProvider =
    StateNotifierProvider.autoDispose<TimeTableNotifier, TimeTableState>(
        (ref) => TimeTableNotifier());

class TimeTableNotifier extends StateNotifier<TimeTableState> {
  late Map<String, List<ReservationEntity>> reservations;

  TimeTableNotifier() : super(_Initial());

  fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    reservations = {
      'زمین 1': [
        ReservationEntity(
            status: ReservationStatus.onSiteReservation,
            fromTime: 8,
            price: 30000,
            userName: 'زرگری'),
        ReservationEntity(
            status: ReservationStatus.onSiteReservation,
            fromTime: 8,
            price: 30000,
            userName: 'مرادی'),
        ReservationEntity(
            status: ReservationStatus.onlineReservation,
            fromTime: 10,
            price: 30000,
            userName: 'ابراهیمی'),
        ReservationEntity(
            status: ReservationStatus.package,
            fromTime: 13,
            price: 30000,
            userName: 'تهرانی'),
      ],
      'زمین 2': [
        ReservationEntity(
            status: ReservationStatus.onSiteReservation,
            fromTime: 6,
            price: 30000,
            userName: 'زرگری'),
        ReservationEntity(
            status: ReservationStatus.onlineReservation,
            fromTime: 15,
            price: 30000,
            userName: 'ساعتی'),
        ReservationEntity(
            status: ReservationStatus.onlineReservation,
            fromTime: 12,
            price: 30000,
            userName: 'رنجبر'),
        ReservationEntity(
            status: ReservationStatus.package,
            fromTime: 23,
            price: 30000,
            userName: 'ابراهیمی'),
      ]
    };
    state = _Loaded();
  }

  switchSlots(Slot from, Slot to) {
    final reservationToMove = reservations[from.field]!
        .where((element) => element.fromTime == from.fromTime)
        .first;
    final result = reservationToMove.copyWith(fromTime: to.fromTime);
    reservations[from.field]!.remove(reservationToMove);
    reservations[to.field]!.add(result);
    state = _Loaded();
  }



  blockSlots(List<Slot> slots) {
    for (var slot in slots) {
      reservations[slot.field]!.add(ReservationEntity(
          status: ReservationStatus.blocked, fromTime: slot.fromTime));
    }
    state = TimeTableState.loaded();

  }

  selectSlot(Slot slot) {
    state.map(selecting: (selectingState) {
      if (selectingState.selectedItems.contains(slot)) {
        var temp = [...selectingState.selectedItems];
        temp.remove(slot);
        state = _Selecting([...temp]);
      } else {
        state = _Selecting([slot, ...selectingState.selectedItems]);
      }
    }, loaded: (_) {
      state = _Selecting([slot]);
    }, initial: (_Initial value) {
      throw Exception('Selecting items before data is loaded!');
    });
  }

  cancelSelection() => state = _Loaded();
}
