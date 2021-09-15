// handles CryptoEvents and returns appropriate CryptoStates
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker/models/coin_model.dart';
import 'package:crypto_tracker/models/failure_model.dart';
import 'package:crypto_tracker/repos/cypto_repo.dart';
import 'package:equatable/equatable.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepo _cryptoRepo;

  CryptoBloc({required CryptoRepo cryptoRepo})
      : _cryptoRepo = cryptoRepo,
        // new state to give an initial state which we defined in crypto state
        super(CryptoState.initial());

  @override
  Stream<CryptoState> mapEventToState(
    CryptoEvent event,
    // the * after async means this is an asynchronus generator function, i.e.,
    // funcitons which allow you to continually return values ( i.e. mapEventToState
    // is always actively listening for changes
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshCoins) {
      yield* _getCoins();
    } else if (event is LoadMoreCoins) {}
  }

  Stream<CryptoState> _getCoins() async* {
    // Request Coins
    try {
      final coins = await _cryptoRepo.getTopCoins();
      // take state and modify status and coins list
      yield state.copyWith(coins: coins, status: CryptoStatus.loaded);
    } on Failure catch (err) {
      yield state.copyWith(
        // take state and modify status to error
        failure: err,
        status: CryptoStatus.error,
      );
    }
  }

// return a stream of cryptostates
  Stream<CryptoState> _mapAppStartedToState() async* {
    // take initial state and modify status to loading
    yield state.copyWith(status: CryptoStatus.loading);
    yield* _getCoins();
  }
}
