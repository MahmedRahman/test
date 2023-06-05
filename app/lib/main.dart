import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future fetchPeople() async {
    String jsonString = await rootBundle.loadString('assets/data_hotels.json');
    //print(jsonString);
    var raw = jsonDecode(jsonString);
    return raw["data"];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('JSON App'),
        ),
        body: FutureBuilder(
          future: fetchPeople(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(snapshot.data![index]["image"]),
                        ListTile(
                          title: Text(snapshot.data![index]["HotelName"]),
                          subtitle: Row(
                            children: [
                              Text(snapshot.data![index]["location"]),
                              Spacer(),
                              Text(snapshot.data![index]["price"]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // Show a loading spinner if the data is loading
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
