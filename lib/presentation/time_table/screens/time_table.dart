import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:time_table/presentation/core/widgets/loading_widget.dart';
import 'package:time_table/presentation/time_table/notifiers/time_table.dart';
import 'package:time_table/presentation/time_table/widgets/dialogs/reserve_block_dialog.dart';
import 'package:time_table/presentation/time_table/widgets/field_reservations.dart';
import 'package:time_table/presentation/time_table/widgets/selecting_slots_row.dart';
import 'package:time_table/presentation/time_table/widgets/status_row.dart';

import '../../core/config/strings.dart';
import '../widgets/dialogs/reserve_form_dialog.dart';

@RoutePage()
class TimeTablePage extends ConsumerWidget {
  const TimeTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(timeTableNotifierProvider);
    final notifier = ref.watch(timeTableNotifierProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 4),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).cardColor,
                      child: Icon(
                        Icons.list_alt_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Text(AppStrings.fieldsSchedule,
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(40))),
                      child: Column(
                        children: [
                          const StatusRow(),
                          state.maybeMap(
                            initial: (_) {
                              notifier.fetchData();
                              return const LoadingWidget();
                            },
                            orElse: () => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 160.0),
                                  child: Row(
                                    children: notifier.reservations.keys
                                        .map((e) => Expanded(
                                                child: Text(
                                              e,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            )))
                                        .toList(),
                                  ),
                                ),
                                Divider(
                                  thickness: 6,
                                ),
                                SizedBox(
                                    height: 80 * 18 + 84,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
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
                                                  (field) => FieldSlots(
                                                      state: state,
                                                      field: field,
                                                      notifier: notifier),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          state.maybeMap(
              orElse: () => Container(),
              selecting: (selectingState) => SelectingSlotsRow(
                  onAccepted: () {
                    showDialog<ReservationStatus>(
                        context: context,
                        builder: (_) => const ReserveBlockDialog())
                        .then((value) {
                      if (value == ReservationStatus.blocked) {
                        notifier.blockSlots(selectingState.selectedItems);
                      } else if (value ==
                          ReservationStatus.onSiteReservation) {
                        showDialog<Map<String, List<ReservationEntity>>>(
                            context: context,
                            builder: (_) => ReserveFormDialog(
                                selectingState.selectedItems))
                            .then((newReservations) {
                          if (newReservations != null) {
                            notifier.addReservations(newReservations);
                          }
                        });
                      }
                    });
                  },
                  onCancelled: () {
                    notifier.cancelSelection();
                  },
                  selectedLength: selectingState.selectedItems.length))
        ],
      ),
    );
  }
}
