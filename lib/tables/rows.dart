import 'package:easy_software/tables/config.dart';
import 'package:flutter/cupertino.dart';

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.value,
    this.textStyle,
  });

  final String value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: textStyle ?? PaginatedTableConfig.rowTextStyle,
      maxLines: PaginatedTableConfig.maxLinesPerRow,
      overflow: TextOverflow.ellipsis,
    );
  }
}
