// for connecting to the API
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// for json decode:
import 'dart:convert';
import 'package:crypto_tracker/models/models.dart';

// get the top coins list from the min-APi.cryptocompare
class CryptoRepo {
  // base url
  static const String _baseUrl = 'https://min-api.cryptocompare.com';
  // private http client
  static const int perPage = 20;
  final http.Client _httpClient;

  // constructor:
  // take in a named parameter called httpclient which can be null.
  // if null set private client to new client else set to parameter
  // we do this because when initiating a new connection from crypto repo, it is
  // likely that given parameter will be null so we need a new connection in
  // that case, however passing in the parameter is helpful in testing.
  CryptoRepo({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  // since we need to get a url, we will 'await' the data. and since we are waiting,
  // the type of func will be async
  Future<List<Coin>> getTopCoins({required int page}) async {
    final requestUrl =
        '$_baseUrl/data/top/totalvolfull?limit=20&tsym=USD&page=$page';
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final coinList = List.from(data['Data']);
        print(data);
        // convert each map to a coin and add all to a list
        return coinList.map((e) => Coin.fromMap(e)).toList();
      }
      return [];
    } catch (error) {
      print(error);
      // throw custom error
      throw Failure(message: error.toString());
    }
  }
}
