import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  DisplayWidget({super.key, required this.temp, required this.realFeel});

  int temp;
  int realFeel;

  String getDayOfWeek(int dayIndex) {
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return daysOfWeek[dayIndex - 1];
  }

  String getMonthName(int monthIndex) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[monthIndex - 1];
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int day = now.day;
    int month = now.month;
    // var date = 25;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage("assets/images/trees-6207925_1920.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$day ${getMonthName(month)}, ${getDayOfWeek(now.weekday)}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Spacer(),
          Row(
            children: [
              const Spacer(),
              Text(
                "$temp °C",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                "Real feel $realFeel °C",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
