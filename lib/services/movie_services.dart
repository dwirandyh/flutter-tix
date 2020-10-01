part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1";

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = jsonDecode(response.body);
    List result = data["results"];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);
    var data = jsonDecode(response.body) as Map<String, dynamic>;

    List genres = data['genres'];
    String language;

    switch (data['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      case 'en':
        language = "English";
        break;
    }

    return MovieDetail(movie,
        language: language,
        genres: genres
            .map((e) => (e as Map<String, dynamic>)['name'].toString())
            .toList());
  }

  static Future<List<Credit>> getCredits(int movieId,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);
    List credits = ((data as Map<String, dynamic>)['cast'] as List);

    return credits
        .map(
          (e) => Credit(
            name: e['name'],
            profilePath: e['profile_path'],
          ),
        )
        .take(8)
        .toList();
  }
}
