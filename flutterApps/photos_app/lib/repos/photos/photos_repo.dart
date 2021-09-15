import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:photos_app/repos/repos.dart';
import 'package:photos_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:photos_app/.env.dart';

class PhotosRepository extends BasePhotosRepository {
  @override
  // base route
  static const _unsplashBaseUrl = 'https://api.unsplash.com/';
  // num of photos to display per page
  // isnt kept private because different pages might need to access it
  static const int numPerPage = 10;

  final http.Client _httpClient;

  // constructor takes in a http client. if no arg, makes a new client.
  PhotosRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();
  @override
  void dispose() {
    // close connection with client
    _httpClient.close();
  }

  @override
  Future<List<Photo>> searchPhotos(
      {@required String query, int page = 1}) async {
    print("repo\n");
    print(query);
    final url =
        '$_unsplashBaseUrl/search/photos?client_id=$unsplashApiKey&page=$page&per_page=$numPerPage&query=$query';

    final response = await _httpClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // get list of results from the json
      final List results = data['results'];
      // loop though each of the results and convert each item into a list of photos.
      final List photos = results.map((e) => Photo.fromMap(e)).toList();
      return photos;
    }
    return []; // if response not successful
  }
}
