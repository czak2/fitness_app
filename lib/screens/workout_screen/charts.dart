import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "My Health Chart",
          style: GoogleFonts.oswald(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Weight Chart",
                  style: GoogleFonts.oswald(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 8,
                    minY: 0,
                    maxY: 6,
                    backgroundColor: Colors.white,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.5,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        margin: 8,
                      ),
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        margin: 8,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(2.6, 2),
                          FlSpot(4.9, 5),
                          FlSpot(6.8, 2.5),
                          FlSpot(8, 4),
                        ],
                        isCurved: true,
                        colors: [Color.fromRGBO(27, 88, 231, 1)],
                        barWidth: 2,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: false,
                          colors: [Colors.blue.withOpacity(0.3)],
                        ),
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Calories Chart",
                  style: GoogleFonts.oswald(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: 8,
                    minY: 0,
                    maxY: 600,
                    backgroundColor: Colors.white,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.5,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey,
                          strokeWidth: 0.5,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      topTitles: SideTitles(showTitles: false),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        margin: 8,
                      ),
                      rightTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                        margin: 8,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 150),
                          FlSpot(2.6, 250),
                          FlSpot(4.9, 350),
                          FlSpot(6.8, 450),
                          FlSpot(8, 550),
                        ],
                        isCurved: true,
                        colors: [Color.fromRGBO(27, 88, 231, 1)],
                        barWidth: 2,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: false,
                          colors: [Colors.blue.withOpacity(0.3)],
                        ),
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
