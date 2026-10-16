// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Movie', json, ($checkedConvert) {
      final val = Movie(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        title: $checkedConvert('title', (v) => v as String),
        originalTitle: $checkedConvert('originalTitle', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
        releaseYear: $checkedConvert('releaseYear', (v) => (v as num).toInt()),
        genres: $checkedConvert(
          'genres',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        director: $checkedConvert('director', (v) => v as String),
        actors: $checkedConvert(
          'actors',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        durationMinutes: $checkedConvert(
          'durationMinutes',
          (v) => (v as num).toInt(),
        ),
        country: $checkedConvert('country', (v) => v as String),
        ageRating: $checkedConvert('ageRating', (v) => v as String),
        posterUrl: $checkedConvert('posterUrl', (v) => v as String),
        rating: $checkedConvert('rating', (v) => (v as num?)?.toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'originalTitle': instance.originalTitle,
  'description': instance.description,
  'releaseYear': instance.releaseYear,
  'genres': instance.genres,
  'director': instance.director,
  'actors': instance.actors,
  'durationMinutes': instance.durationMinutes,
  'country': instance.country,
  'ageRating': instance.ageRating,
  'posterUrl': instance.posterUrl,
  'rating': instance.rating,
};
