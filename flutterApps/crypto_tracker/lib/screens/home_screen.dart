import 'package:crypto_tracker/blocs/crypto/crypto_bloc.dart';
import 'package:crypto_tracker/models/models.dart';
import 'package:crypto_tracker/repos/repos.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Coins"),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            // set begin and end to describe the flow of gradience
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              // Add an ! at the end of colors.grey to let flutter know that this
              // is not a null value
              Colors.grey[900]!,
            ],
          )),
          // list of coins
          // the state passed here is of type object so blocbuilder doesn't actually
          // know what the state it. which is why it is important to explicitly spec
          // type in blocbuilder.
          child: BlocBuilder<CryptoBloc, CryptoState>(
            builder: (context, state) {
              switch (state.status) {
                case CryptoStatus.loaded:
                  // refresh indiactor widget allows us to easily pull  down the
                  // screen and refresh our coins list to current data.
                  return RefreshIndicator(
                      onRefresh: () async {
                        print("Refresh");
                        context.read<CryptoBloc>().add(RefreshCoins());
                      },
                      child: ListView.builder(
                          // put ! to silence null error sine we already checked is snapshot
                          // has data
                          itemCount: state.coins.length,
                          itemBuilder: (BuildContext context, int index) {
                            // index starts at 1 so ++
                            final coin = state.coins[index];
                            return ListTile(
                              // wrapping texts inside a column to have both indices and text
                              // centered (in leading)
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${++index}',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              title: Text(
                                coin.fullName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                coin.name,
                                style: const TextStyle(color: Colors.white70),
                              ),

                              trailing: Text(
                                // to string as fixed takes care of decimal positions.
                                // the first $ is escaped to show the actual $ sign.
                                "\$${coin.price.toStringAsFixed(4)}",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          }));
                case CryptoStatus.error:
                  return Center(
                    child: Text(
                      state.failure.message,
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                  break;
                default:
                  return CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  );
              }
            },
          )),
    );
  }
}
