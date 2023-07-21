

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'time_widget.dart';
import '../date_picker_timeline/extra/color.dart';
import '../date_picker_timeline/extra/style.dart';
import 'gestures/tap.dart';

class TimePicker extends StatefulWidget {
  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  /// 
  final List<String> orari;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final TimePickerController? controller;

  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Background color for the selector
  final Color selectionColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  /// TextStyle for Month Value
  final TextStyle timeTextStyle;

  /// Current Selected Date
  final String?/*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<String>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final TimeChangeListener? onTimeChange;

  /// Locale for the calendar default: en_us
  final String locale;

  TimePicker(
    this.orari,
    
    {
    Key? key,
    this.width = 70,
    this.height = 44,
    this.controller,
    this.timeTextStyle = const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500,),
    this.selectedTextColor = Colors.white,
    this.selectionColor = AppColors.defaultSelectionColor,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.onTimeChange,
    this.locale = "it_IT",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => new _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String? _currentTime;

  ScrollController _controller = ScrollController();

  late final TextStyle selectedTimeStyle;

  late final TextStyle deactivatedTimeStyle;

  @override
  void initState() {
  
    // Set initial Values
    _currentTime = widget.initialSelectedDate;

    widget.controller?.setTimePickerState(this);

    selectedTimeStyle =
      widget.timeTextStyle.copyWith(color: widget.selectedTextColor);

    deactivatedTimeStyle =
        widget.timeTextStyle.copyWith(color: widget.deactivatedColor);

    super.initState();
  }

  void removeCurrentTime() {
    setState(() {
      _currentTime = null;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.orari.length,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          // get the date object based on the index position
          // if widget.startDate is null then use the initialDateValue
          String orario = widget.orari[index];

          bool isDeactivated = false;

          // check if this date needs to be deactivated for only DeactivatedDates
          if (widget.inactiveDates != null) {
            for (String inactiveDate in widget.inactiveDates!) {
              if (orario == inactiveDate) {
                isDeactivated = true;
                break;
              }
            }
          }

          // Check if this date is the one that is currently selected
          bool isSelected = _currentTime != null
              ? orario == _currentTime
              : false;

          // Return the Date Widget
          return TimeWidget(
            time: orario,
            timeTextStyle: isDeactivated
                ? deactivatedTimeStyle
                : isSelected
                    ? selectedTimeStyle
                    : widget.timeTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor:
                isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate) {
              // Don't notify listener if date is deactivated
              if (isDeactivated) return;

              // A date is selected
              widget.onTimeChange?.call(selectedDate);

              setState(() {
                _currentTime = selectedDate;
              });

            },
          );
        },
      ),
    );
  }
}

class TimePickerController {
  _TimePickerState? _timePickerState;

  void setTimePickerState(_TimePickerState state) {
    _timePickerState = state;
  }

  get ora{
    return int.parse(_timePickerState!._currentTime!.substring(0, 2));
  }

  get minuti {
    return int.parse(_timePickerState!._currentTime!.substring(3, 5));
  }

  /// Function to deselect the currently selected TimeWidget
  void deselectTime() async {
    assert(_timePickerState != null,
        'TimePickerController is not attached to any TimePicker View.');

    _timePickerState?.removeCurrentTime();

    // Deselect the current date
    
  }


  void jumpToSelection() {
    assert(_timePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _timePickerState!._controller
        .jumpTo(_calculateDateOffset(_timePickerState!._currentTime!));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_timePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _timePickerState!._controller.animateTo(
        _calculateDateOffset(_timePickerState!._currentTime!),
        duration: duration,
        curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// In case a date is out of range nothing will happen
  void animateToDate(String time,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_timePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _timePickerState!._controller.animateTo(_calculateDateOffset(time),
        duration: duration, curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// this will also set that date as the current selected date
  void setDateAndAnimate(String time,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_timePickerState != null,
    'DatePickerController is not attached to any DatePicker View.');

    _timePickerState!._controller.animateTo(_calculateDateOffset(time),
        duration: duration, curve: curve);

    if (_calculateDateOffset(time) >= 0 && _calculateDateOffset(time) <= _timePickerState!.widget.orari.length ) {
      // date is in the range
      _timePickerState!._currentTime = time;
    }
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(String time) {

    int offset = 0;

    for(int i = 0; i < _timePickerState!.widget.orari.length; i++) {
      if (_timePickerState!.widget.orari[i] == time) offset = i;
    }

    return (offset * _timePickerState!.widget.width) + (offset * 6);
  }
}