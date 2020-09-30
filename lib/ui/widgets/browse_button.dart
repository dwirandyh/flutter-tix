part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  final Map<String, AssetImage> genreAssets = {
    "Action": AssetImage("assets/ic_action.png"),
    "War": AssetImage("assets/ic_war.png"),
    "Drama": AssetImage("assets/ic_drama.png"),
    "Music": AssetImage("assets/ic_music.png"),
    "Horror": AssetImage("assets/ic_horror.png"),
    "Crime": AssetImage("assets/ic_crime.png"),
  };

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 4),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFEEF1F8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: SizedBox(
              height: 36,
              child: Image(image: genreAssets[genre]),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          genre,
          style: blackTextFont.copyWith(fontSize: 13),
        )
      ],
    );
  }
}
