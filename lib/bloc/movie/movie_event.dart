part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMovies extends MovieEvent {
  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieEvent {
  final Movie movie;

  FetchMovieDetail(this.movie);

  @override
  List<Object> get props => [movie];
}
