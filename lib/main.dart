import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'CsvData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  Future<List<List<String>>> getCsvData(String path) async {
    //List<CsvData> list = [];
    List<List<String>> list = [[]];
    String csv = await rootBundle.loadString(path);

    for (String line in csv.split('\n')) {
      //print(line);
      //List rows = line.split(','); // split by comma
      list[counter] = line.split(',');
      //CsvData rowData = CsvData(time: rows[0], imsi: rows[1], lat: rows[2]);
      list.add(list[counter]);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getCsvData('assets/soracom_acc_payload.csv'),
        builder:
            (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
          final list = snapshot.data as List<List<String>>;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(children: <Widget>[
            for (var i = 1; i < list.length - 1; i++)
              ListTile(
                leading: Text(list[i][0]),
                title: Text(list[i][1]),
                subtitle: Text(list[i][2]),
              ),
          ]);
        },
      ),
    );
  }
}
