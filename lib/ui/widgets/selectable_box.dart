part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  SelectableBox(
      {this.isSelected,
      this.isEnabled,
      this.width,
      this.height,
      this.onTap,
      this.textStyle,
      @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(this.text));
  }
}
