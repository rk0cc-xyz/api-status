import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum APIStatusIndicator { normal, timeout, loading, error }

class APIStatusField extends StatelessWidget {
  final String _apisite;

  APIStatusField({Key? key, required String apisite})
      : this._apisite = apisite[0] == "/" ? apisite : "/$apisite",
        super(key: key);

  Future<int> get _apistatus async {
    var c = http.Client();
    var resp =
        await c.head(Uri.parse(_apisite)).timeout(const Duration(seconds: 15));

    int status = resp.statusCode;

    c.close();

    return status;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<int>(
      future: _apistatus,
      builder: (context, snapshot) {
        throw UnimplementedError();
      });
}
