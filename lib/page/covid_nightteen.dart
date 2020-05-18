import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CovidNineTeen extends StatefulWidget {
  @override
  _CovidNineTeenState createState() => _CovidNineTeenState();
}

class _CovidNineTeenState extends State<CovidNineTeen> {
  final int textGrayColor = 0xFFBDBDBD;
  final int textRedColor = 0xFFEF5350;
  final int listCount = 10;
  final Dio dio = Dio();
  var listData;

  Future<Response> getData() async {
    Response response;
    try {
      response = await dio.get('https://disease.sh/v2/countries');
      if (response.statusCode == 200 && response.data != null) {
        return response;
      }
    } on DioError catch (e) {
      debugPrint('dio error $e');
    }
    return response;
  }

  Widget _createListView(dynamic data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown,
      ),
      child: ListTile(
        leading: Text('${data['country']}'),
        title: Text('${data['cases']}'),
        trailing: Icon(Icons.device_hub),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
//    getData().then((value) {
//      listData = value;
//      print(listData);
//    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Covid19'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              'CoronaVirus Cases',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '90000',
            style: TextStyle(
              color: Colors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Column(
                  children: <Widget>[
                    Text('1',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('1',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Container(
                width: size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Column(
                  children: <Widget>[
                    Text('1',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    Text('1',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext buildContext, AsyncSnapshot snap) {
                if (snap.hasData) {
                  Response res = snap.data;
                  return ListView.builder(
                      itemCount: res.data.length,
                      itemBuilder: (context, index) => _createListView(res.data[index]));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
