import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// An [Enum] for define API server status
enum APIStatusIndicator {
  /// Work fine.
  normal,

  /// Response timeout.
  timeout,

  /// Waiting API server response.
  loading,

  /// Error from API server.
  error,

  /// Error when getting API response.
  client_error
}

extension APIStatusIndicatorExtension on APIStatusIndicator {
  Color get statusColour {
    switch (this) {
      case APIStatusIndicator.normal:
        return Colors.green[700]!;
      case APIStatusIndicator.timeout:
        return Colors.orangeAccent[400]!;
      case APIStatusIndicator.loading:
        return Color(0xff8f8f8f);
      case APIStatusIndicator.error:
        return Colors.redAccent[400]!;
      case APIStatusIndicator.client_error:
        return Colors.red[900]!;
    }
  }

  String get description {
    switch (this) {
      case APIStatusIndicator.normal:
        return "This API service runs normally.";
      case APIStatusIndicator.timeout:
        return "Request timeout, unable to get API server status.";
      case APIStatusIndicator.loading:
        return "Waiting API response.";
      case APIStatusIndicator.error:
        return "This API service out of order.";
      case APIStatusIndicator.client_error:
        return "Something wrong when trying to handle API status in client site.";
    }
  }
}

extension on APIStatusIndicator {
  CircleAvatar get statusDot => CircleAvatar(
        backgroundColor: this.statusColour,
        maxRadius: 6,
        minRadius: 4,
      );

  ListTile get descriptionTile => ListTile(
      leading: statusDot,
      contentPadding: const EdgeInsets.all(4),
      title: Text(description,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300)));
}

void openStatusHelp(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
            content: SizedBox(
                width: 350,
                height: 275,
                child: ListView(
                    children: APIStatusIndicator.values
                        .map((i) => i.descriptionTile)
                        .toList())),
            actions: <TextButton>[
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"))
            ]));

class APIStatusField extends StatefulWidget {
  final String _apisite;
  final String label;

  APIStatusField({Key? key, required String apisite, required this.label})
      : this._apisite = (() {
          String og = apisite;

          if (og[0] != "/") {
            og = "/$og";
          }

          if (og[og.length - 1] != "/") {
            og = "$og/";
          }

          return og;
        }()),
        super(key: key);

  @override
  State<APIStatusField> createState() => _APIStatusFieldState();
}

class _APIStatusFieldState extends State<APIStatusField> {
  late final Future<int> _apistatus;

  @override
  void initState() {
    super.initState();
    _apistatus = Future(() async {
      var c = http.Client();

      http.Request req = http.Request(
          "HEAD", Uri.parse("https://www.rk0cc.xyz/api${widget._apisite}"));

      var resp;
      int tolerance = 0;

      while (true) {
        try {
          resp = await c.send(req).timeout(const Duration(seconds: 15));
          break;
        } catch (e) {
          // Maybe temperoary error for getting CORS
          if (tolerance++ < 10) {
            continue;
          }
          throw e;
        }
      }

      c.close();

      return resp.statusCode;
    });
  }

  ListTile _listTileBuilder(BuildContext context,
      {required APIStatusIndicator status}) {
    return ListTile(
        leading: status.statusDot,
        title: Text(widget.label,
            style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<int>(
      future: _apistatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _listTileBuilder(context, status: APIStatusIndicator.loading);
        } else if (snapshot.hasError) {
          return _listTileBuilder(context,
              status: APIStatusIndicator.client_error);
        } else {
          int status = snapshot.data!;

          if (status >= 500) {
            return _listTileBuilder(context, status: APIStatusIndicator.error);
          } else if (status >= 400) {
            return _listTileBuilder(context,
                status: APIStatusIndicator.client_error);
          } else if (status == -1) {
            return _listTileBuilder(context,
                status: APIStatusIndicator.timeout);
          }

          return _listTileBuilder(context, status: APIStatusIndicator.normal);
        }
      });
}

class APIStatusCard extends StatelessWidget {
  final Map<String, String> _sitemap;
  final String title;

  APIStatusCard(
      {Key? key, required Map<String, String> sitemap, required this.title})
      : assert(sitemap.isNotEmpty),
        this._sitemap = Map.unmodifiable(sitemap),
        super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(4),
        semanticContainer: true,
        child: Column(
            children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold))),
          const Divider()
        ]..addAll(_sitemap.entries
                .map((e) => APIStatusField(apisite: e.value, label: e.key)))),
      );
}
