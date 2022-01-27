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

  Future<Transaction?> save(Transaction transaction, String password) async {
    final Uri uri = Uri.http(_baseUrl, _transactionsUrl);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'password': password
    };

    final response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    const String unmapError = 'Erro desconhecido';

    throw HttpException(
        _statusCodeResponses[response.statusCode] ?? unmapError);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Valor da transação indeterminado',
    401: 'Senha incorreta',
    409: 'transaction already exists',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
