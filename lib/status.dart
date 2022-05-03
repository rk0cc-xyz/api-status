import 'package:flutter/material.dart';

enum APIStatusIndicator { normal, timeout, loading, error }

class APIStatusField extends StatelessWidget {
  final String _apisite;

  APIStatusField({Key? key, required String apisite})
      : this._apisite = apisite[0] == "/" ? apisite : "/$apisite",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
