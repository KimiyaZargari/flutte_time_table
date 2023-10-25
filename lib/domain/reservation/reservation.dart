import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';

@freezed
class ReservationEntity with _$ReservationEntity {
  factory ReservationEntity(
      {required ReservationStatus status,
      int? price,
      required int fromTime,
      String? userName}) = _ReservationEntity;
}

enum ReservationStatus {
  onlineReservation,
  onSiteReservation,
  blocked,
  free,
  package;

  @override
  String toString() {
    switch (this) {
      case ReservationStatus.onlineReservation:
        return 'رزرو آنلاین';
      case ReservationStatus.onSiteReservation:
        return 'رزرو در محل';

      case ReservationStatus.blocked:
        return 'بلاک';

      case ReservationStatus.free:
        return 'آزاد';

      case ReservationStatus.package:
        return 'پکیج گروهی';
    }
  }

  Color get cardColor {
    switch (this) {
      case ReservationStatus.onlineReservation:
        return Colors.greenAccent;
      case ReservationStatus.onSiteReservation:
        return Colors.blueAccent;
      case ReservationStatus.blocked:
        return Colors.redAccent;
      case ReservationStatus.free:
        return Colors.white54;
      case ReservationStatus.package:
        return Colors.limeAccent;
    }
  }

  static ReservationStatus getStatusFromInt(int status) {
    if (status == 0) {
      return ReservationStatus.free;
    } else if (status == 2) {
      return ReservationStatus.onlineReservation;
    } else if (status == 3) {
      return ReservationStatus.onSiteReservation;
    } else if (status == 4) {
      return ReservationStatus.package;
    }
    return ReservationStatus.blocked;
  }
}
