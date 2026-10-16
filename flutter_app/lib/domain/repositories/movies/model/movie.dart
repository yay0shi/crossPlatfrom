import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(checked: true)
class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.description,
    required this.releaseYear,
    required this.genres,
    required this.director,
    required this.actors,
    required this.durationMinutes,
    required this.country,
    required this.ageRating,
    required this.posterUrl,
    this.rating,
  });

  final int id;
  final String title;
  final String originalTitle;
  final String description;
  final int releaseYear;
  final List<String> genres;
  final String director;
  final List<String> actors;
  final int durationMinutes;
  final String country;
  final String ageRating;
  final String posterUrl;
  final double? rating;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    originalTitle,
    description,
    releaseYear,
    genres,
    director,
    actors,
    durationMinutes,
    country,
    ageRating,
    posterUrl,
    rating,
  ];
}
