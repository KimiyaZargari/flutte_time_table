import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:time_table/domain/time_table/slot.dart';
import 'package:time_table/presentation/core/config/strings.dart';

class UnblockSlotDialog extends StatelessWidget {
  const UnblockSlotDialog({Key? key}) : super(key: key);

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
              AppStrings.unblock,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {
                    context.router.pop(true);
                  },
                  child: const Text(AppStrings.accept),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                  child: const Text(AppStrings.cancel),
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
