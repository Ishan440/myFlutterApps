import 'package:crypto_tracker/repos/cypto_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:crypto_tracker/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/crypto/crypto_bloc.dart';

void main() {
  // ensures that equatable stringify is only true in debug mode and not in
  // release mode
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    return RepositoryProvider(
      // instantiate a crypto repo which can be used in one or multiple blocs
      create: (context) => CryptoRepo(),
      child: MaterialApp(
        title: 'Flutter Crypto price tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.tealAccent,
          primarySwatch: Colors.blue,
        ),
        // since we have bloc integrated now, wrap this in a bloc provider
        // so home screen will build the ui base on the bloc state
        home: BlocProvider(
            create: (context) => CryptoBloc(
                  // since we already instantiated a crypto repo in the context of
                  // repo provider, we are telling the cryptorepo to read the first
                  // object of type cryptorepo. this is the syntax to use for reading
                  // the crypto repo from anywhere in our widget tree.
                  cryptoRepo: context.read<CryptoRepo>(),
                  // .. is a cascading operator that lets you do operations on the object
                )..add(AppStarted()),
            child: HomeScreen()),
      ),
    );
  }
}
