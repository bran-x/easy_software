// enum TableHeaderType { text, icon, iconAndText }
enum TableHeaderType {
  text,
  icon,
  iconAndText,
}

class TableHeader {
  final String label;
  final int flex;
  TableHeader({
    required this.label,
    this.flex = 1,
  });
}
