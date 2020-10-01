part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: accentColor1),
          SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
            ),
          ),
          FutureBuilder(
            future: MovieServices.getDetails(movie),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                MovieDetail movieDetail = snapshot.data;
                return ListView(
                  children: [
                    backdrop(context,
                        backdropPath: movieDetail.backdropPath,
                        posterPath: movieDetail.posterPath),
                    titleSection(
                        title: movieDetail.title,
                        genre: movieDetail.genres.join(', '),
                        language: movieDetail.language),
                    crewSection(),
                    overviewSection(overview: movieDetail.overview),
                    bookSection(),
                    SizedBox(height: 44)
                  ],
                );
              } else {
                return Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      SpinKitFadingCircle(
                        color: accentColor1,
                        size: 50,
                      ),
                      Text("Loading, please wait", style: blackTextFont),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget backdrop(BuildContext context,
          {@required String backdropPath, @required String posterPath}) =>
      Stack(
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      imageBaseURL + "w1280" + backdropPath ?? posterPath),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 271,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, 1),
                end: Alignment(0, 0.06),
                colors: [Colors.white, Colors.white.withOpacity(0)],
              ),
            ),
          ),
          Container(
            width: 24,
            height: 24,
            margin: EdgeInsets.only(top: 20, left: defaultMargin),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          )
        ],
      );

  Widget titleSection(
          {@required String title,
          @required String genre,
          @required String language}) =>
      Container(
        margin: EdgeInsets.only(top: 16, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$title",
              style: blackTextFont.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "$genre - $language",
              style: blackTextFont.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xFFADADAD),
              ),
            ),
            SizedBox(height: 6),
            RatingStars(
              voteAverage: 7,
              mainAxisAlignment: MainAxisAlignment.center,
              color: Color(0xFFADADAD),
            )
          ],
        ),
      );

  Widget crewSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: 24, left: defaultMargin, right: defaultMargin),
            child: Text(
              "Cast & Crew",
              style: blackTextFont.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          FutureBuilder(
            future: MovieServices.getCredits(movie.id),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<Credit> credits = snapshot.data;
                return SizedBox(
                  height: 115,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: credits.length,
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: (index == credits.length - 1)
                              ? defaultMargin
                              : 16),
                      child: CreditCard(credits[index]),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 50,
                  child: SpinKitFadingCircle(
                    color: accentColor1,
                  ),
                );
              }
            },
          )
        ],
      );

  Widget overviewSection({@required String overview}) => Container(
        margin: EdgeInsets.only(
          bottom: 30,
          top: 16,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Storyline",
              style: blackTextFont.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              overview,
              style: blackTextFont.copyWith(
                fontSize: 14,
                color: Color(0xFFADADAD),
              ),
            ),
          ],
        ),
      );

  Widget bookSection() => Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 55),
        child: RaisedButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: mainColor,
          child: Text(
            "Continue to Book",
            style: whiteTextFont.copyWith(fontSize: 16),
          ),
        ),
      );
}
