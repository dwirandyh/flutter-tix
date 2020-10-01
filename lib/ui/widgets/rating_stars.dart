part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final double voteAverage;
  final double starSize;
  final double fontSize;
  final Color color;

  RatingStars(
      {this.voteAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      this.color = Colors.white,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    int n = (this.voteAverage / 2).round();

    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        index < n ? MdiIcons.star : MdiIcons.star,
        color: index < n ? accentColor2 : Color(0xFFC4C4C4),
        size: starSize,
      ),
    );

    widgets.add(SizedBox(width: 3));
    widgets.add(Text(
      "$voteAverage/10",
      style: whiteNumberFont.copyWith(
          fontWeight: FontWeight.w300, fontSize: fontSize, color: color),
    ));

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: widgets,
    );
  }
}
