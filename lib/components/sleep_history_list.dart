import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

class SleepHistoryListPage extends StatefulWidget {
  const SleepHistoryListPage({Key? key}) : super(key: key);

  @override
  State<SleepHistoryListPage> createState() => _SleepHistoryListPageState();
}

class _SleepHistoryListPageState extends State<SleepHistoryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future:
              get(Uri.parse("https://suyaa-express-2.herokuapp.com/testdata")),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.hasData) {
              return const Text('List');
            }
            return const Text('Loading');
          },
        ),
      ),
    );
  }
}
