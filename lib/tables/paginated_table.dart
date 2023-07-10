import 'package:easy_software/tables/headers.dart';
import 'package:flutter/cupertino.dart';

import 'config.dart';

class PaginatedTable<T> extends StatefulWidget {
  const PaginatedTable({
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

  // Fixed parameters
  final double footerHeight = 50;

  @override
  State<PaginatedTable<T>> createState() => _PaginatedTableState<T>();
}

class _PaginatedTableState<T> extends State<PaginatedTable<T>> {
  int currentPage = 1;
  double maxHeight = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      maxHeight =
          constrains.maxHeight - widget.headerHeight - widget.footerHeight - 1;
      if (currentPage > totalPages) {
        currentPage = totalPages;
      }
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
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.columnSpacing),
                      child: Text(
                        widget.headers[i].label,
                        style: widget.headerTextStyle ??
                            PaginatedTableConfig.headerTextStyle,
                      ),
                    ),
                  ),
                if (widget.showButtons)
                  Container(
                    width: 150,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CupertinoColors.systemGrey,
                          width: 1,
                        ),
                      ),
                    ),
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
            child: Column(
              children: [
                for (int i = startIndex; i < endIndex; i++)
                  Container(
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
                            width: 150,
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
                                    child: const Icon(
                                      CupertinoIcons.info,
                                      color: CupertinoColors.activeGreen,
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
          SizedBox(
            height: widget.footerHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: onTapFirstPageButton,
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.backward_end),
                ),
                const SizedBox(
                  width: 10,
                ),
                CupertinoButton(
                  onPressed: onTapBackButton,
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.back),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.headerBackgroundColor ??
                          PaginatedTableConfig.headerBackgroundColor ??
                          CupertinoColors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$currentPage/$totalPages',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.headerBackgroundColor ??
                          PaginatedTableConfig.headerBackgroundColor,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CupertinoButton(
                  onPressed: onTapForwardButton,
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.forward),
                ),
                const SizedBox(
                  width: 10,
                ),
                CupertinoButton(
                  onPressed: onTapEndButton,
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.forward_end),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  int get totalItems => widget.data.length;
  int get itemsPerPage {
    // Get the height of the table
    // Divide by the row height
    // Return the result
    int value = (maxHeight / widget.rowHeight).floor();
    return value;
  }

  int get totalPages {
    if (itemsPerPage == 0) {
      return 1;
    }
    int totalpages = (totalItems / itemsPerPage).ceil();
    return totalpages == 0 ? 1 : totalpages;
  }

  int get startIndex => (currentPage - 1) * itemsPerPage;
  int get endIndex {
    int endIndex = startIndex + itemsPerPage;
    return endIndex > totalItems ? totalItems : endIndex;
  }

  void onTapBackButton() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
    }
  }

  void onTapForwardButton() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
    }
  }

  void onTapEndButton() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage = totalPages;
      });
    }
  }

  void onTapFirstPageButton() {
    if (currentPage > 1) {
      setState(() {
        currentPage = 1;
      });
    }
  }
}
