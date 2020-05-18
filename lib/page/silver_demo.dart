import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SilverDemo extends StatefulWidget {
  @override
  _SilverDemoState createState() => _SilverDemoState();
}

class _SilverDemoState extends State<SilverDemo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp().then((value) =>
        debugPrint(value)
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('SliverAppBar'),
              backgroundColor: Colors.green,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate(
                [
                  Container(color: Colors.red),
                  Container(color: Colors.purple),
                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                  Container(color: Colors.pink),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = Dio();
      response = await dio.post('https://jxjasper.com/JasperFitness/Member/MembershipQuery',
          data: {
            "Mem_Cellphone": "0928075503"
          }
      );
      print(response.data.toString());
    } catch (e) {
      print(e);
    }
  }
}

