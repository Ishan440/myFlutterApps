part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

// handled inside the crypto bloc.
class AppStarted extends CryptoEvent {}

class RefreshCoins extends CryptoEvent {}

class LoadMoreCoins extends CryptoEvent {}
