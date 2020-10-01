part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        header(context),
        nowPlaying(context),
        browseMovie(),
        comingSoon(),
        promo(),
        SizedBox(height: 100)
      ],
    );
  }

  Widget header(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: accentColor1,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
        child:
            BlocBuilder<UserBloc, UserState>(builder: (blocContext, userState) {
          if (userState is UserLoaded) {
            if (imageFileToUpload != null) {
              uploadImage(imageFileToUpload).then(
                (downloadURL) {
                  imageFileToUpload = null;
                  context
                      .bloc<UserBloc>()
                      .add(UpdateData(profileImage: downloadURL));
                },
              );
            }

            return Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF5F558B), width: 1)),
                  child: Stack(
                    children: <Widget>[
                      SpinKitFadingCircle(
                        color: accentColor2,
                        size: 50,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: (userState.user.profilePicture == ""
                                  ? AssetImage("assets/user_pic.png")
                                  : NetworkImage(
                                      userState.user.profilePicture)),
                              fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          78,
                      child: Text(
                        userState.user.name,
                        style: whiteTextFont.copyWith(fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: "id_ID", decimalDigits: 0, symbol: "IDR ")
                          .format(userState.user.balance),
                      style: yellowNumberFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            );
          } else {
            return SpinKitFadingCircle(
              color: accentColor2,
              size: 50,
            );
          }
        }),
      );

  Widget nowPlaying(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 20),
            child: Text(
              "Now Playing",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 140,
            child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(0, 5);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 16,
                    ),
                    child: MovieCard(movies[index], onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movies[index]),
                        ),
                      );
                    }),
                  ),
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            }),
          )
        ],
      );

  Widget browseMovie() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 20),
            child: Text(
              "Browse Movie",
              style: blackTextFont.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        userState.user.selectedGenres.length,
                        (index) => BrowseButton(
                            userState.user.selectedGenres[index]))),
              );
            } else {
              return SpinKitFadingCircle(color: mainColor, size: 50);
            }
          })
        ],
      );

  Widget comingSoon() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 20),
            child: Text(
              "Coming Soon",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 140,
            child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(5, 10);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? defaultMargin : 0,
                      right: (index == movies.length - 1) ? defaultMargin : 16,
                    ),
                    child: ComingSoonCard(movies[index]),
                  ),
                );
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            }),
          )
        ],
      );

  Widget promo() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text(
              "Get Lucky Daay",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: dummyPromos
                .map((e) => Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultMargin, 0, defaultMargin, 16),
                    child: PromoCard(e)))
                .toList(),
          ),
        ],
      );
}
