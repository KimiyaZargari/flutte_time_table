import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:time_table/domain/time_table/slot.dart';

class ReserveBlockDialog extends StatelessWidget {
  const ReserveBlockDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "رزرو یا بلاک",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    context.router.pop(ReservationStatus.onSiteReservation);
                  },
                  child: const Text('رزرو'),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error),
                  child: const Text('بلاک'),
                  onPressed: () {
                    context.router.pop(ReservationStatus.blocked);
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
