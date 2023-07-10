import 'package:easy_software/charts/charts.dart';
import 'package:flutter/material.dart';

class ChartsExample extends StatelessWidget {
  const ChartsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        child: DonutChart(
          showIndicators: true,
          vertical: false,
          data: [
            DonutChartElement(
              'Elemento 1',
              25,
              Colors.red,
            ),
            DonutChartElement(
              'Elemento 2',
              37,
              Colors.blue,
            ),
            DonutChartElement(
              'Elemento 3',
              18,
              Colors.green,
            ),
            DonutChartElement(
              'Elemento 4',
              10,
              Colors.yellow.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}
