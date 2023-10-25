import 'package:flutter/material.dart';
import 'package:time_table/domain/time_table/slot.dart';
import 'package:time_table/presentation/time_table/widgets/reservation_card.dart';

import '../../../domain/reservation/reservation.dart';

class EmptySlot extends StatelessWidget {
  final Slot emptySlot;
  final Function() selectSlot;
  final Function() onTap;
  final bool isSelected;

  const EmptySlot(
      {required this.emptySlot,
      required this.isSelected,
      required this.onTap,
      required this.selectSlot,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => selectSlot(),
      onDoubleTap: () => selectSlot(),
      onTap: onTap,
      child: ReservationCard(
        ReservationEntity(
            fromTime: emptySlot.fromTime, status: ReservationStatus.free),
        isSelected: isSelected,
      ),
    );
  }
}
