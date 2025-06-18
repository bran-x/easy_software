import 'dart:math';

import 'package:easy_software/charts/indicators.dart';
import 'package:easy_software/charts/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DonutChartPainter extends CustomPainter {
  final List<DonutChartElement> data;
  DonutChartPainter({
    required this.data,
    this.strokePercent = 0.2,
    this.gap = 0.08,
    this.borderRadius = 0.2,
    this.isInteger = true,
  });

  final double strokePercent;
  final double gap;
  final double borderRadius;
  final bool isInteger;

  final double minSweep = 12 * pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double minSize = min(size.width, size.height);
    double strokeWidth = minSize * strokePercent;
    double outerRadius = minSize / 2;
    double innerRadius = outerRadius - strokeWidth;

    double total =
        data.fold(0, (previousValue, element) => previousValue + element.value);
    double startAngle = -pi / 2;
    double sweepAngle = 0;
    double totalAngle = 2 * pi;
    if (data.length > 1) {
      totalAngle -= gap * data.length;
    }
    for (int i = 0; i < data.length; i++) {
      sweepAngle = (data[i].value / total) * totalAngle;
      if (total == 0) {
        sweepAngle = 2 * pi;
      }
      double R = (outerRadius - innerRadius) * borderRadius;
      final initialAngle = startAngle;
      final finalAngle = startAngle + sweepAngle;
      double radius2 = sqrt(outerRadius * (outerRadius - 2 * R));
      double dtheta2 = asin(R / (outerRadius - R));
      double radius1 = sqrt(innerRadius * (innerRadius + 2 * R));
      double dtheta1 = asin(R / (innerRadius + R));
      while (2 * dtheta1 > sweepAngle ||
          2 * dtheta2 > sweepAngle ||
          radius2 < radius1) {
        R = R / 2;
        radius2 = sqrt(outerRadius * (outerRadius - 2 * R));
        dtheta2 = asin(R / (outerRadius - R));
        radius1 = sqrt(innerRadius * (innerRadius + 2 * R));
        dtheta1 = asin(R / (innerRadius + R));
      }
      final Path path = Path()
        ..moveTo(centerX + radius1 * cos(initialAngle),
            centerY + radius1 * sin(initialAngle))
        ..lineTo(centerX + radius2 * cos(initialAngle),
            centerY + radius2 * sin(initialAngle))
        ..arcToPoint(
          Offset(centerX + outerRadius * cos(initialAngle + dtheta2),
              centerY + outerRadius * sin(initialAngle + dtheta2)),
          radius: Radius.circular(R),
          clockwise: true,
        )
        ..arcToPoint(
          Offset(centerX + outerRadius * cos(finalAngle - dtheta2),
              centerY + outerRadius * sin(finalAngle - dtheta2)),
          radius: Radius.circular(outerRadius),
          clockwise: true,
          largeArc: sweepAngle > pi,
        )
        ..arcToPoint(
          Offset(centerX + radius2 * cos(finalAngle),
              centerY + radius2 * sin(finalAngle)),
          radius: Radius.circular(R),
          clockwise: true,
        )
        ..lineTo(centerX + radius1 * cos(finalAngle),
            centerY + radius1 * sin(finalAngle))
        ..arcToPoint(
          Offset(centerX + innerRadius * cos(finalAngle - dtheta1),
              centerY + innerRadius * sin(finalAngle - dtheta1)),
          radius: Radius.circular(R),
          clockwise: true,
        )
        ..arcToPoint(
          Offset(centerX + innerRadius * cos(initialAngle + dtheta1),
              centerY + innerRadius * sin(initialAngle + dtheta1)),
          radius: Radius.circular(innerRadius),
          clockwise: false,
          largeArc: sweepAngle > pi,
        )
        ..arcToPoint(
          Offset(centerX + radius1 * cos(initialAngle),
              centerY + radius1 * sin(initialAngle)),
          radius: Radius.circular(R),
          clockwise: true,
        )
        ..lineTo(centerX + radius2 * cos(initialAngle),
            centerY + radius2 * sin(initialAngle))
        ..close();

      canvas.drawPath(
        path,
        Paint()..color = total > 0 ? data[i].color : Colors.grey.shade400,
      );
      if (total == 0) {
        return;
      }

      // Draw the text
      double textAngle = startAngle + sweepAngle / 2;
      double textRadius = (innerRadius + outerRadius) / 2;

      double fontSize = clampDouble(minSize / 12, 4, 16);

      TextSpan span = TextSpan(
        text: data[i].value.toStringAsFixed(isInteger ? 0 : 1),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );

      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      tp.layout();

      double textX = centerX + textRadius * cos(textAngle) - tp.width / 2;
      double textY = centerY + textRadius * sin(textAngle) - tp.height / 2;

      if (sweepAngle > minSweep) {
        tp.paint(canvas, Offset(textX, textY));
      }

      // Update the angle
      startAngle += sweepAngle;

      if (i < data.length - 1) {
        startAngle += gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DonutChart extends StatefulWidget {
  const DonutChart({
    super.key,
    required this.data,
    this.showIndicators = true,
    this.vertical = true,
    this.strokePercent = 0.1,
    this.gap = 0.05,
    this.borderRadius = 0.2,
    this.isInteger = true,
  });

  final List<DonutChartElement> data;
  final bool showIndicators;
  final bool vertical;

  final double strokePercent;
  final double gap;
  final double borderRadius;
  final bool isInteger;

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomPaint(
                      painter: DonutChartPainter(
                        data: widget.data,
                        gap: widget.gap,
                        borderRadius: widget.borderRadius,
                        isInteger: widget.isInteger,
                      ),
                    ),
                  ),
                ),
                if (widget.showIndicators && !widget.vertical)
                  const SizedBox(
                    width: 20,
                  ),
                if (widget.showIndicators && !widget.vertical)
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: Wrap(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            children: [
                              for (int i = 0; i < widget.data.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ChartIndicator(
                                    indicatorHeight: 50,
                                    indicatorWidth: 100,
                                    color: widget.data[i].color,
                                    value: widget.data[i].value,
                                    label: widget.data[i].name,
                                    isInteger: widget.isInteger,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (widget.showIndicators && widget.vertical)
            const SizedBox(
              height: 20,
            ),
          if (widget.showIndicators && widget.vertical)
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      children: [
                        for (int i = 0; i < widget.data.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChartIndicator(
                              indicatorHeight: 50,
                              indicatorWidth: 100,
                              color: widget.data[i].color,
                              value: widget.data[i].value,
                              label: widget.data[i].name,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
