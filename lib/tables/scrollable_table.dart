import 'package:easy_software/tables/config.dart';
import 'package:easy_software/tables/headers.dart';
import 'package:flutter/cupertino.dart';

class ScrollableTable<T> extends StatefulWidget {
  const ScrollableTable({
    super.key,
    required this.data,
    required this.headers,
    this.showNumbering = true,
    this.rowHeight = 50,
    this.headerHeight = 50,
    this.commonPadding = 20,
    this.columnSpacing = 10,
    this.rounded = true,
    this.showButtons = true,
    this.onEdit,
    this.onDelete,
    this.onDetails,
    required this.rowElementsBuilder,
    this.headerBackgroundColor,
    this.headerTextStyle,
    this.rowTextStyle,
    this.customButtons = const [],
    this.customButtonActions = const [],
    this.buttonsWidth = 150,
    this.minSizeButtons,
    this.headerTextAlign,
  });

  final List<T> data;
  final List<TableHeader> headers;
  final bool rounded;
  final bool showNumbering;
  final bool showButtons;
  final void Function(T model)? onEdit;
  final void Function(T model)? onDelete;
  final void Function(T model)? onDetails;
  final int rowHeight;
  final int headerHeight;
  final int commonPadding;
  final double columnSpacing;
  final List<Widget> Function(T model) rowElementsBuilder;
  final Color? headerBackgroundColor;
  final TextStyle? headerTextStyle;
  final TextStyle? rowTextStyle;
  final TextAlign? headerTextAlign;
  final List<Widget> customButtons;
  final List<void Function(T model)> customButtonActions;
  final double buttonsWidth;
  final double? minSizeButtons;

  @override
  State<ScrollableTable<T>> createState() => _ScrollableTableState<T>();
}

class _ScrollableTableState<T> extends State<ScrollableTable<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.headerHeight.toDouble(),
          padding: EdgeInsets.symmetric(
            horizontal: widget.commonPadding.toDouble(),
          ),
          decoration: BoxDecoration(
            color: widget.headerBackgroundColor ??
                PaginatedTableConfig.headerBackgroundColor,
            borderRadius: widget.rounded ? BorderRadius.circular(10.0) : null,
          ),
          child: Row(
            children: [
              if (widget.showNumbering)
                SizedBox(
                  width: 50,
                  child: Center(
                    child: Text(
                      'Nº',
                      style: widget.headerTextStyle ??
                          PaginatedTableConfig.headerTextStyle,
                    ),
                  ),
                ),
              for (int i = 0; i < widget.headers.length; i++)
                Expanded(
                  flex: widget.headers[i].flex,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widget.columnSpacing),
                    child: Text(
                      widget.headers[i].label,
                      textAlign: widget.headerTextAlign,
                      style: widget.headerTextStyle ??
                          PaginatedTableConfig.headerTextStyle,
                    ),
                  ),
                ),
              if (widget.showButtons)
                SizedBox(
                  width: widget.buttonsWidth,
                  child: Center(
                    child: Text(
                      'Acciones',
                      style: widget.headerTextStyle ??
                          PaginatedTableConfig.headerTextStyle,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, i) {
              return Container(
                height: widget.rowHeight.toDouble(),
                padding: EdgeInsets.symmetric(
                  horizontal: widget.commonPadding.toDouble(),
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    if (widget.showNumbering)
                      SizedBox(
                        width: 50,
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: widget.rowTextStyle ??
                                PaginatedTableConfig.rowTextStyle?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ...List.generate(
                      widget.headers.length,
                      (j) {
                        final T item = widget.data[i];
                        final List<Widget> rowElements =
                            widget.rowElementsBuilder(item);
                        return Expanded(
                          flex: widget.headers[j].flex,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.columnSpacing),
                            child: rowElements[j],
                          ),
                        );
                      },
                    ),
                    if (widget.showButtons)
                      SizedBox(
                        width: widget.buttonsWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (widget.onEdit != null)
                              CupertinoButton(
                                onPressed: widget.onEdit != null
                                    ? () {
                                        widget.onEdit!(widget.data[i]);
                                      }
                                    : null,
                                padding: EdgeInsets.zero,
                                minSize: widget.minSizeButtons,
                                child: const Icon(
                                  CupertinoIcons.pencil,
                                  color: CupertinoColors.activeBlue,
                                ),
                              ),
                            if (widget.onDelete != null)
                              CupertinoButton(
                                onPressed: widget.onDelete != null
                                    ? () {
                                        widget.onDelete!(widget.data[i]);
                                      }
                                    : null,
                                padding: EdgeInsets.zero,
                                minSize: widget.minSizeButtons,
                                child: const Icon(
                                  CupertinoIcons.trash,
                                  color: CupertinoColors.destructiveRed,
                                ),
                              ),
                            if (widget.onDetails != null)
                              CupertinoButton(
                                onPressed: widget.onDetails != null
                                    ? () {
                                        widget.onDetails!(widget.data[i]);
                                      }
                                    : null,
                                padding: EdgeInsets.zero,
                                minSize: widget.minSizeButtons,
                                child: const Icon(
                                  CupertinoIcons.info,
                                  color: CupertinoColors.activeGreen,
                                ),
                              ),
                            for (int j = 0;
                                j < widget.customButtons.length;
                                j++)
                              CupertinoButton(
                                onPressed: () {
                                  widget.customButtonActions[j](widget.data[i]);
                                },
                                padding: EdgeInsets.zero,
                                minSize: widget.minSizeButtons,
                                child: widget.customButtons[j],
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
