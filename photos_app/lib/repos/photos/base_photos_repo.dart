import 'package:photos_app/repos/repos.dart';
import 'package:photos_app/models/models.dart';

abstract class BasePhotosRepository extends BaseRepository {
  // asynchronus fetching of photos
  Future<List<Photo>> searchPhotos({String query, int page});
}
