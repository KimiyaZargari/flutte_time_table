import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_table/domain/reservation/reservation.dart';

import '../../../../domain/time_table/slot.dart';
import '../../../core/config/strings.dart';

final _priceProvider = StateProvider.autoDispose<int>((ref) => 0);
final _nameProvider = StateProvider.autoDispose<String>((ref) => '');
final _formProvider =
    Provider.autoDispose<GlobalKey<FormState>>((ref) => GlobalKey<FormState>());

class ReserveFormDialog extends ConsumerWidget {
  final List<Slot> slots;

  const ReserveFormDialog(this.slots, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final price = ref.watch(_priceProvider);
    final name = ref.watch(_nameProvider);

    return Dialog(
      child: Form(
        key: ref.watch(_formProvider),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        AppStrings.reserveSession,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0, bottom: 8),
                      child: Text(AppStrings.clientName),
                    ),
                    TextFormField(
                      onChanged: (val) {
                        ref.read(_nameProvider.notifier).state = val.trim();
                      },
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return AppStrings.necessaryField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0, bottom: 8),
                      child: Text(AppStrings.price),
                    ),
                    TextFormField(
                      onChanged: (val) {
                        ref.read(_priceProvider.notifier).state =
                            int.tryParse(val!.trim())!;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return AppStrings.necessaryField;
                        }
                        if (int.tryParse(val) == 0) {
                          return AppStrings.necessaryField;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        suffix: Text('تومان'),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                        onPressed: () {
                          context.popRoute();
                        },
                        child: const Text(AppStrings.cancel)),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          final formKey = ref.read(_formProvider);
                          if (formKey.currentState!.validate()) {
                            Map<String, List<ReservationEntity>> reservations =
                                {};
                            for (var slot in slots) {
                              if (!reservations.keys.contains(slot.field)) {
                                reservations.addAll({slot.field: []});
                              }
                              reservations[slot.field]!.add(ReservationEntity(
                                  status: ReservationStatus.onSiteReservation,
                                  userName: name,
                                  price: price,
                                  fromTime: slot.fromTime));
                            }
                            context.popRoute(reservations);
                          }
                        },
                        child: const Text(AppStrings.accept)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
