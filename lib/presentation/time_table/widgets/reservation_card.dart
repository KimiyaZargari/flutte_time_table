import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_table/domain/reservation/reservation.dart';
import 'package:time_table/presentation/core/config/strings.dart';

class ReservationCard extends StatelessWidget {
  final ReservationEntity reservationModel;
  final bool isSelected;

  const ReservationCard(this.reservationModel,
      {this.isSelected = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      child: Card(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : reservationModel.status.cardColor,
          child: Builder(builder: (_) {
            switch (reservationModel.status) {
              case ReservationStatus.onlineReservation:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(reservationModel.userName!),
                    Text(reservationModel.price.toString()),
                  ],
                );
              case ReservationStatus.onSiteReservation:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(reservationModel.userName!),
                    Text(reservationModel.price.toString()),
                  ],
                );

              case ReservationStatus.blocked:
                return Center(child: const Text(AppStrings.slotIsBlocked));

              case ReservationStatus.free:
                return Container();


            }
          })),
    );
  }
}
