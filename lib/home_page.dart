import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgr_flutter/fetch_data/api_client.dart';
import 'package:mgr_flutter/fetch_data/task_entry_model.dart';
import 'package:mgr_flutter/file_utils/file_utils.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int time = 0;

  bool fetchDataExamination = false;
  bool fileExamination  = false;
  bool databaseExamination  = false;

  List<TaskEntry> apiData = new List();
  String fileData = "";

  Stopwatch stopwatch = new Stopwatch();

  void fetchData(){
    stopwatch.reset();
    stopwatch.start();
    ApiClient().fetchData().then((v){
      setState(() {
        apiData.addAll(v.tasks);
      });
    });
    setState(() {
      stopwatch.stop();
      fetchDataExamination = true;
      time = stopwatch.elapsedMilliseconds;
    });
  }

  void file(){
    stopwatch.reset();
    stopwatch.start();
    FileUtils fileUtils = FileUtils(DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now().toLocal()));
    fileUtils.writeFile().then((value){
      fileUtils.readFile().then((content) {
        setState(() {
          fileData = content;
        });
      });
    });
    setState(() {
      stopwatch.stop();
      fileExamination = true;
      time = stopwatch.elapsedMilliseconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: new Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: ()=>fetchData(),
                    child: Text("Pobierz dane z API"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: new Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: ()=>file(),
                    child: Text("Stwórz i wyświetl dane z pliku"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: new Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("Stwórz i pobierz dane z lokalnej bazy danych"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Center(child: new Text("Czas operacji: ${time} ms")))
              ],
            ),
          ),
          if (fetchDataExamination || fileExamination || databaseExamination)
            FlatButton(
                onPressed: () {
                  setState(() {
                    fetchDataExamination = fileExamination = databaseExamination = false;
                  });
                },
                child: Text("RESET")),
          if (fetchDataExamination)
            Expanded(
              child: ListView(
                children: apiData.map((x) {
                  return ListTile(
                    title: Text(
                        "UserId: ${x.userId}, Id: ${x.id}, Title: ${x.title}, Completed: ${x.completed}"),
                  );
                }).toList(),
              ),
            ),
          if (fileExamination)
            Expanded(child: Text(fileData))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}