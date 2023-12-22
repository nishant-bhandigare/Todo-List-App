import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int day = now.day;
    int month = now.month;
    var date = 25;

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

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage("assets/images/windmill-5689011_1920.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$date ${getMonthName(month)}, ${getDayOfWeek(now.weekday)}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const Spacer(),
          const Row(
            children: [
              Spacer(),
              Text(
                "0 °C",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const Row(
            children: [
              Spacer(),
              Text(
                "Real feel 0 °C",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
