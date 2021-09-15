import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photos_app/models/models.dart';

class PhotoCard extends StatelessWidget {
  // widget will take in a photo
  final Photo photo;
  // constructor
  const PhotoCard({Key key, @required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            )
          ],
          image: DecorationImage(
              // fit it to the complete card.
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(photo.url))),
    );
    ;
  }
}
