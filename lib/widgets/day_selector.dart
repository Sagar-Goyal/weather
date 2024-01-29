import 'package:flutter/material.dart';
import 'package:weather/enums/day.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({super.key, required this.day, required this.setDay});

  final Day day;
  final Function setDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextButton(
          autofocus: true,
          onPressed: () async {
            setDay(Day.today);
          },
          child: Text(
            "Today",
            style: TextStyle(
              color: day == Day.today ? Colors.white : const Color(0xFF6D6D6D),
              fontSize: day == Day.today ? 18 : 14,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setDay(Day.tommorow);
          },
          child: Text(
            "Tomorrow",
            style: TextStyle(
              color:
                  day == Day.tommorow ? Colors.white : const Color(0xFF6D6D6D),
              fontSize: day == Day.tommorow ? 18 : 14,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Next 7 Days",
            style: TextStyle(
              color: Color(0xFF6D6D6D),
            ),
          ),
        ),
      ],
    );
  }
}
