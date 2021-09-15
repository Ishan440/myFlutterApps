import 'package:flutter/material.dart';
import 'package:photos_app/repos/repos.dart';
import 'package:photos_app/models/models.dart';
import 'package:photos_app/widgets/widgets.dart';

class PhotosScreen extends StatefulWidget {
  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

// with just a textinput field, we would have to wait to click done on the
// keyboard to stop writing/remove the keyboard. We wrap the keyboard in a gesture
// detector widget so that when we tap anywhere on the screen the focus
// of view changes to the screen (i.e. keyboard will go down)
class _PhotosScreenState extends State<PhotosScreen> {
  @override
  Widget build(BuildContext context) {
    // search query, default value is programming
    String _query = 'programming';
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
        ),
        body: Column(
          children: [
            TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onSubmitted: (val) {
                  // trim whitespace and check if input empty
                  if (val.trim().isNotEmpty) {
                    setState(() => _query = val);
                    print("set state:\n");
                    print(_query);
                  }
                }),
            // A future builder widget is a widget which builds itself on the basis
            // the snapshot it gets on interacting with the 'future', i.e., a future
            // returning function like asyncs.
            Expanded(
                child: FutureBuilder(
              future: PhotosRepository().searchPhotos(query: _query),
              builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
                // make sure we can render the UI
                // connectionState done means our snapshot has data
                if (snapshot.connectionState == ConnectionState.done) {
                  print("future builder:\n");
                  print(_query);
                  final List<Photo> photos = snapshot.data;
                  // see what the output was

                  // return a grid view of photos
                  // Slivers are portions of scrollable area. Sliver lists
                  // have better scrolling functionalities than data table.
                  return GridView.builder(
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      // how many children we want horizontally on the screen
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final photo = photos[index];

                      return PhotoCard(photo: photo);
                    },
                    itemCount: photos.length,
                  );
                }
                // if null show loading
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
