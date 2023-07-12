/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'gestures/tap.dart';

class TimeWidget extends StatelessWidget {
  final double? width;
  final String time;
  final TextStyle? timeTextStyle;
  final Color selectionColor;
  final TimeSelectionCallback? onDateSelected;
  final String? locale;

  TimeWidget({
    required this.time,
    required this.timeTextStyle,
    required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(time, // Date
                  style: timeTextStyle),
            ],
          ),
        ),
      ),
      onTap: () {
        onDateSelected?.call(this.time);
      },
    );
  }
}