import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:time_table/presentation/time_table/notifiers/time_table.dart';
import 'package:time_table/presentation/time_table/widgets/dialogs/reserve_form_dialog.dart';
import 'package:time_table/presentation/time_table/widgets/dialogs/unblock_stol_dialog.dart';
import 'package:time_table/presentation/time_table/widgets/reservation_card.dart';

import '../../../domain/time_table/slot.dart';
import 'dialogs/move_reservation.dart';
import 'dialogs/reserve_block_dialog.dart';
import 'empty_slot.dart';

class FieldSlots extends StatelessWidget {
  final TimeTableNotifier notifier;
  final TimeTableState state;
  final String field;

  const FieldSlots(
      {required this.state,
      required this.field,
      required this.notifier,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Iterable<int>.generate(18).map((index) {
        final reservation = notifier.reservations[field]!
            .where((element) => element.fromTime == index + 6);
        if (reservation.isEmpty ||
            reservation.first.status == ReservationStatus.free) {
          final emptySlot = Slot(field: field, fromTime: index + 6);
          return DragTarget<Slot>(
            builder: (_, __, ___) => EmptySlot(
              emptySlot: emptySlot,
              selectSlot: () {
                notifier.selectSlot(emptySlot);
              },
              isSelected: state.maybeMap(
                  orElse: () => false,
                  selecting: (state) {
                    return state.selectedItems.contains(emptySlot);
                  }),
              onTap: () {
                state.mapOrNull(loaded: (_) {
                  showDialog<ReservationStatus>(
                      context: context,
                      builder: (_) => const ReserveBlockDialog()).then((value) {
                    if (value == ReservationStatus.blocked) {
                      notifier.blockSlots([emptySlot]);
                    } else if (value == ReservationStatus.onSiteReservation) {
                      showDialog<Map<String, List<ReservationEntity>>>(
                              context: context,
                              builder: (_) => ReserveFormDialog([emptySlot]))
                          .then((newReservations) {
                        if (newReservations != null)
                          notifier.addReservations(newReservations);
                      });
                    } else {
                      throw UnimplementedError();
                    }
                  });
                }, selecting: (_) {
                  notifier.selectSlot(emptySlot);
                });
              },
            ),
            onWillAccept: (_) {
              return true;
            },
            onAccept: (from) {
              showDialog(
                      context: context,
                      builder: (_) =>
                          MoveReservationDialog(from: from, to: emptySlot))
                  .then((value) {
                if (value) {
                  notifier.switchSlots(from, emptySlot);
                }
              });
            },
          );
        } else if (reservation.first.status == ReservationStatus.blocked) {
          return GestureDetector(
              onTap: () {
                showDialog<bool>(
                    context: context,
                    builder: (_) => const UnblockSlotDialog()).then((value) {
                  if (value?? false) {
                    notifier.unblockSlot(reservation.first, field);
                  }
                });
              },
              child: ReservationCard(reservation.first));
        } else {
          return Draggable<Slot>(
            data: Slot(fromTime: reservation.first.fromTime, field: field),
            feedback: SizedBox(
              width: (MediaQuery.of(context).size.width - 160)/2,
              child: ReservationCard(reservation.first),
            ),
            childWhenDragging:
                const SizedBox(height: 76, child: Card(color: Colors.black38)),
            child: ReservationCard(reservation.first),
          );
        }
      }).toList(),
    ));
  }
}
