import 'package:flutter/material.dart';

import '../../../domain/reservation/reservation.dart';

class StatusRow extends StatelessWidget {
  const StatusRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ReservationStatus.values
          .map((e) => Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          shape: BoxShape.circle,
                          color: e.cardColor),
                    ),
                    Text(e.toString())
                  ],
                ),
              ))
          .toList(),
    );
  }
}
