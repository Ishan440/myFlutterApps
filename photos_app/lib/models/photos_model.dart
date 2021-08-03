import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:photos_app/models/models.dart';

class Photo extends Equatable {
  final String id;
  final String url;
  final String description;
  final User user;

  const Photo({
    @required this.id,
    @required this.url,
    @required this.description,
    @required this.user,
  });

  // props are the properties we want to compare
  // Equatable saves us the time for implementing __eq__ method for 2 photo instances.
  @override
  List<Object> get props => [id, url, description, user];
  // stringify (inbuilt  method)
  @override
  // a toString function
  bool get stringify => true;

  // populate from json
  factory Photo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null; //  error check
    return Photo(
      id: map['id'],
      url: map['url'],
      description: map['description'] ?? "No Description",
      // The ?? is an operator for checking null val
      user: User.fromMap(map['user']),
    );
  }
}
