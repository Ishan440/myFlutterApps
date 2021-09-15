// material.dart Contains most of the widgets we'll use
import "package:flutter/material.dart";

// main is the entry point to our app

void main() {
  runApp(MyApp());
}

// In flutter there are two different type of widgets:
// stateless and statefull. A checkbox is statefull whereas a button is
// is stateless
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Materiall App is the backbone of our flutter App
    // It manages the top level navigator for navigation between pages
    // and maintains the same theme throughout
    return MaterialApp(
        title: 'Hello World',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen());
  }
}

// TIP: just type stl to autowrite the code for a sateless widget.
// use stfl for statefull. Select any widget and do cmd + . for options

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // use const so that compiler know to not load these settings
        // this everytime. This is good for performance
        title: const Text("Hello World!"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.bike_scooter_outlined,
            color: Colors.white,
            size: 28.0,
          )),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Row(
                // for row main axis is vertical by default,
                // and horizontal for column
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "ListTitle: $index",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  OutlineButton(
                    onPressed: () {},
                    child: const Text("I'm button"),
                  )
                ],
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AnotherScreen(),
                  )));
        },
      ),
    );
  }
}

class AnotherScreen extends StatefulWidget {
  // const AnotherScreen({Key? }) : super(key: key);
  @override
  _AnotherScreenState createState() => _AnotherScreenState();
}

// the '_' at the start of the name indicates private variables
class _AnotherScreenState extends State<AnotherScreen> {
  @override
  bool _showModifiedPanel = false;

  Widget build(BuildContext context) {
    return Scaffold(
      // appbar is important for having that back button
      appBar: AppBar(),
      body: PageView.builder(itemBuilder: (BuildContext context, int index) {
        return Panel(index: index, showModifiedPanel: _showModifiedPanel);
      }),
      // this floating baction button will change the panel state
      floatingActionButton: FloatingActionButton(
        // on pressing this button, change state
        onPressed: () {
          // it is really IMPORTANT to call set state else the
          // widget tree will not rebuild to reflect the change.
          setState(() {
            _showModifiedPanel = !_showModifiedPanel;
          });
        },
        child: const Icon(Icons.ac_unit),
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final int index;
  final bool showModifiedPanel;
  const Panel({
    required this.index,
    required this.showModifiedPanel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // do animation for this much time (in this case change border radius)
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(20.0),
      // handles how the box looks
      decoration: BoxDecoration(
          // important for color to be in here else error arises
          color: Colors.red, //backgorund image of container
          borderRadius: showModifiedPanel
              ? BorderRadius.circular(100.0)
              : BorderRadius.circular(10.0),
          //
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 6),
              blurRadius: 12.0,
            )
          ],
          // background image for the panel
          image: const DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1627785678714-d04b8952d9d0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2775&q=80"),
              fit: BoxFit.cover)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Panel $index",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w200)),
          const Icon(
            Icons.grain,
            color: Colors.white,
            size: 50,
          )
        ],
      ),
    );
  }
}
