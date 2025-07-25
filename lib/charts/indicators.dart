import 'package:flutter/cupertino.dart';

class ChartIndicator extends StatelessWidget {
  const ChartIndicator({
    super.key,
    required this.indicatorHeight,
    required this.indicatorWidth,
    required this.color,
    required this.value,
    required this.label,
    this.isInteger = true,
  });

  final double indicatorHeight;
  final double indicatorWidth;
  final Color color;
  final double value;
  final String label;
  final bool isInteger;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: indicatorHeight,
      width: indicatorWidth + 20,
      child: Row(
        children: [
          Container(
            height: indicatorHeight,
            width: 8,
            color: color,
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: indicatorWidth,
            height: indicatorHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: indicatorHeight / 2,
                  child: Text(
                    label.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
                SizedBox(
                  height: indicatorHeight / 2,
                  child: Text(
                    value.toStringAsFixed(isInteger ? 0 : 1),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
