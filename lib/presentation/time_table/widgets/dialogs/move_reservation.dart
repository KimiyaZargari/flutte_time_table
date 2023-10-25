import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_table/domain/time_table/slot.dart';

class MoveReservationDialog extends StatelessWidget {
  final Slot from, to;

  const MoveReservationDialog({required this.from, required this.to, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "جا به جایی رزرو",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 16),
              child: Text(
                'آیا می خواهید سانس${from.sessionString}  در ${from.field} را با سانس ${to.sessionString} در ${to.field} جا به جا کنید؟ ',
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {
                    context.router.pop(true);
                  },
                  child: const Text('بله'),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                  child: const Text('خیر'),
                  onPressed: () {
                    context.router.pop(false);
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
