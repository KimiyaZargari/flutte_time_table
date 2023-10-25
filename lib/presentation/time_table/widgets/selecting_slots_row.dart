import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectingSlotsRow extends StatelessWidget {
  final int selectedLength;

  const SelectingSlotsRow({required this.selectedLength, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 3, child: Text('$selectedLength سانس انتخواب شده است.')),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('لغو'))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('تایید'))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
