import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Coin extends Equatable {
  final String name;
  final String fullName;
  final double price;

  Coin({
    required this.name,
    required this.fullName,
    required this.price,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, fullName, price];

  // convert each map into a coin model

  factory Coin.fromMap(Map<String, dynamic> map) {
    return Coin(
        name: map['CoinInfo']?['Name'] ?? '' as String,
        fullName: map['CoinInfo']?['FullName'] ?? '' as String,
        // if map raw doesnt have usd key then this becomes null and if usd
        // doesnt have a price key then also null.
        price: (map['RAW']?['USD']?['PRICE'] ?? 0).toDouble());
  }
}
