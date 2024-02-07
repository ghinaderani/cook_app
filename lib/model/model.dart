// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CookModel {
  // String id;
  String recipe_name;
  String thumbnail;
  String video_link;
  int duration;
  List<dynamic> ingredients;
  CookModel({
    // required this.id,
    required this.recipe_name,
    required this.thumbnail,
    required this.video_link,
    required this.duration,
    required this.ingredients,
  });

  CookModel copyWith({
    // String? id,
    String? recipe_name,
    String? thumbnail,
    String? video_link,
    int? duration,
    List<dynamic>? ingredients,
  }) {
    return CookModel(
      // id: id ?? this.id,
      recipe_name: recipe_name ?? this.recipe_name,
      thumbnail: thumbnail ?? this.thumbnail,
      video_link: video_link ?? this.video_link,
      duration: duration ?? this.duration,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      // 'id': id,
      'recipe_name': recipe_name,
      'thumbnail': thumbnail,
      'video_link': video_link,
      'duration': duration,
      'ingredients': ingredients,
    };
  }

  factory CookModel.fromMap(Map<dynamic, dynamic> map) {
    return CookModel(
      // id: map['id'] as String,
      recipe_name: map['recipe_name'] as String,
      thumbnail: map['thumbnail'] as String,
      video_link: map['video_link'] as String,
      duration: map['duration'] as int,
      ingredients: List<dynamic>.from((map['ingredients'] as List<dynamic>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory CookModel.fromJson(String source) => CookModel.fromMap(json.decode(source) as Map<dynamic, dynamic>);

  @override
  String toString() {
    return 'CookModel( recipe_name: $recipe_name, thumbnail: $thumbnail, video_link: $video_link, duration: $duration, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant CookModel other) {
    if (identical(this, other)) return true;
  
    return 
      // other.id == id &&
      other.recipe_name == recipe_name &&
      other.thumbnail == thumbnail &&
      other.video_link == video_link &&
      other.duration == duration &&
      listEquals(other.ingredients, ingredients);
  }

  @override
  int get hashCode {
    return 
      recipe_name.hashCode ^
      thumbnail.hashCode ^
      video_link.hashCode ^
      duration.hashCode ^
      ingredients.hashCode;
  }
}
