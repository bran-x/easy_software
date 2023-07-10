import 'dart:math';

import 'package:easy_software/charts/indicators.dart';
import 'package:easy_software/charts/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DonutChartPainter extends CustomPainter {
  final List<DonutChartElement> data;
  DonutChartPainter({
    required this.data,
    this.strokePercent = 0.2,
    this.gap = 0.08,
    this.borderRadius = 16.0,
  });

  final double strokePercent;
  final double gap;
  final double borderRadius;

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

      Path path = Path();
      path.moveTo(centerX + outerRadius * cos(startAngle + gap),
          centerY + outerRadius * sin(startAngle + gap));

      path.arcTo(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: outerRadius),
        startAngle + gap,
        sweepAngle - 2 * gap,
        false,
      );

      path.arcToPoint(
        Offset(
            centerX +
                (outerRadius - borderRadius) * cos(startAngle + sweepAngle),
            centerY +
                (outerRadius - borderRadius) * sin(startAngle + sweepAngle)),
        radius: Radius.circular(borderRadius),
      );

      path.lineTo(
          centerX + (innerRadius + borderRadius) * cos(startAngle + sweepAngle),
          centerY +
              (innerRadius + borderRadius) * sin(startAngle + sweepAngle));

      path.arcToPoint(
        Offset(centerX + innerRadius * cos(startAngle + sweepAngle - gap),
            centerY + innerRadius * sin(startAngle + sweepAngle - gap)),
        radius: Radius.circular(borderRadius),
      );

      path.arcTo(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: innerRadius),
        startAngle + sweepAngle - gap,
        -sweepAngle + 2 * gap,
        false,
      );

      path.arcToPoint(
        Offset(centerX + (innerRadius + borderRadius) * cos(startAngle),
            centerY + (innerRadius + borderRadius) * sin(startAngle)),
        radius: Radius.circular(borderRadius),
      );

      path.lineTo(centerX + (outerRadius - borderRadius) * cos(startAngle),
          centerY + (outerRadius - borderRadius) * sin(startAngle));

      path.arcToPoint(
        Offset(centerX + outerRadius * cos(startAngle + gap),
            centerY + outerRadius * sin(startAngle + gap)),
        radius: Radius.circular(borderRadius),
      );

      path.close();

      canvas.drawPath(
        path,
        Paint()..color = data[i].color,
      );

      // Draw the text
      double textAngle = startAngle + sweepAngle / 2;
      double textRadius = (innerRadius + outerRadius) / 2;

      TextSpan span = TextSpan(
        text: data[i].value.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
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

      tp.paint(canvas, Offset(textX, textY));

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
  });

  final List<DonutChartElement> data;
  final bool showIndicators;
  final bool vertical;

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
                      painter: DonutChartPainter(data: widget.data),
                    ),
                  ),
                ),
                if (widget.showIndicators && !widget.vertical)
                  SizedBox(
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
            SizedBox(
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
