import 'dart:convert';
import 'package:bytebank/model/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  final String _baseUrl = 'localhost:8080';
  final String _transactionsUrl = '/transactions';

  Future<List<Transaction>> findAll() async {
    final Uri uri = Uri.http(_baseUrl, _transactionsUrl);
    final Response response = await client.get(uri);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final Uri uri = Uri.http(_baseUrl, _transactionsUrl);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'password': '1000'
    };

    final response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode(transaction.toJson()),
    );

    final responseJson = jsonDecode(response.body);
    return Transaction.fromJson(responseJson);
  }
}
