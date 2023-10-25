import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:time_table/domain/time_table/slot.dart';
import 'package:time_table/presentation/core/widgets/loading_widget.dart';
import 'package:time_table/presentation/time_table/notifiers/time_table.dart';
import 'package:time_table/presentation/time_table/widgets/dialogs/reserve_block_dialog.dart';
import 'package:time_table/presentation/time_table/widgets/status_row.dart';
import '../widgets/dialogs/move_reservation.dart';
import '../widgets/reservation_card.dart';

@RoutePage()
class TimeTablePage extends ConsumerWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(timeTableNotifierProvider);
    final notifier = ref.watch(timeTableNotifierProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Card(
          child: ListView(
            children: [
              const StatusRow(),
              state.maybeMap(
                initial: (_) {
                  notifier.fetchData();
                  return const LoadingWidget();
                },
                orElse: () => SizedBox(
                    height: 80 * 18 + 84,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 160,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: Iterable<int>.generate(18)
                                  .map((e) => SizedBox(
                                        height: 80,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                              '${e + 6}:00',
                                            ))),
                                            const Divider(
                                              height: 0,
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList()),
                        ),
                        Expanded(
                          child: Row(
                            children: notifier.reservations.keys
                                .map(
                                  (field) => Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children:
                                        Iterable<int>.generate(18).map((index) {
                                      final reservation = notifier
                                          .reservations[field]!
                                          .where((element) =>
                                              element.fromTime == index + 6);
                                      if (reservation.isEmpty ||
                                          reservation.first.status ==
                                              ReservationStatus.free) {
                                        final emptySlot = Slot(
                                            field: field, fromTime: index + 6);
                                        return DragTarget<Slot>(
                                          builder: (_, __, ___) =>
                                              GestureDetector(
                                            onLongPressDown: (_) {
                                              notifier.selectSlot(emptySlot);
                                            },
                                            onTap: () {
                                              state.mapOrNull(loaded: (_) {
                                                showDialog<ReservationStatus>(
                                                        context: context,
                                                        builder: (_) =>
                                                            const ReserveBlockDialog())
                                                    .then((value) {
                                                  if (value ==
                                                      ReservationStatus
                                                          .blocked) {
                                                    notifier
                                                        .blockSlot(emptySlot);
                                                  }
                                                });
                                              }, selecting: (_) {
                                                notifier.selectSlot(emptySlot);
                                              });
                                            },
                                            child: ReservationCard(
                                              reservation.isEmpty
                                                  ? ReservationEntity(
                                                      fromTime: index + 6,
                                                      status: ReservationStatus
                                                          .free)
                                                  : reservation.first,
                                              isSelected: state.maybeMap(
                                                  orElse: () => false,
                                                  selecting: (state) {
                                                    return state.selectedItems
                                                        .contains(emptySlot);
                                                  }),
                                            ),
                                          ),
                                          onWillAccept: (_) {
                                            return true;
                                          },
                                          onAccept: (from) {
                                            showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        MoveReservationDialog(
                                                            from: from,
                                                            to: emptySlot))
                                                .then((value) {
                                              if (value) {
                                                notifier.switchSlots(
                                                    from, emptySlot);
                                              }
                                            });
                                          },
                                        );
                                      } else {
                                        return Draggable<Slot>(
                                          data: Slot(
                                              fromTime:
                                                  reservation.first.fromTime,
                                              field: field),
                                          feedback: SizedBox(
                                            width: 400,
                                            child: ReservationCard(
                                                reservation.first),
                                          ),
                                          childWhenDragging: const SizedBox(
                                              height: 76,
                                              child:
                                                  Card(color: Colors.black38)),
                                          child: ReservationCard(
                                              reservation.first),
                                        );
                                      }
                                    }).toList(),
                                  )),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
