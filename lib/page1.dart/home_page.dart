import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
// import 'package:smart_parking/blocs/sensor_blocs/sensor_bloc.dart';
// import 'package:smart_parking/blocs/sensor_blocs/sensor_event.dart';
// import 'package:smart_parking/blocs/sensor_blocs/sensor_state.dart';
// import 'package:smart_parking/models/sensor_data_model.dart';
import 'package:http/http.dart' as http;

import '../models/sensor_data_model.dart';
import '../provider/themeprovider.dart';
// import 'package:smart_parking/provider/themeprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url, response;
  Timer? timer;
  List data = [];
  List<SensorData> dataList = [];
  // List<SensorData> _electionlistToDisplay = [];
  bool _isLoading = true;
  // bool _isLightTheme = true;

  Future<List<SensorData>> getData() async {
    url = Uri.parse(
        "https://io.adafruit.com/api/v2/rambhandhari/feeds?x-aio-key=aio_wcJt56x74UraDqWvmitc1Va7sJ6U");
    response = await http.get(url);
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        dataList = data.map((e) => (SensorData.fromJson(e))).toList();

        _isLoading = false;
        print("this is called");
      });
    } else {
      // Get.snackbar("Error!", "Some network error occurred");
    }

    return dataList;
  }

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getData());
    getData();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(231, 255, 255, 255),
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => ZoomDrawer.of(context)!.toggle(),
                icon: const Icon(Icons.menu)),
            Text(
              "SMART PARKING",
              style: TextStyle(color: Color.fromARGB(255, 26, 1, 114)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: IconButton(
                iconSize: 17,
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                // padding: EdgeInsets.all(0),
                icon: (themeProvider.themeMode == ThemeMode.light)
                    ? Icon(Icons.dark_mode_rounded)
                    : Icon(Icons.light_mode_rounded),
              ),
            ),
            Text(
              themeProvider.themeMode == ThemeMode.light
                  ? "Light Mode"
                  : "Dark Mode",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: themeProvider.themeMode == ThemeMode.light
                    ? Theme.of(context).hintColor
                    : Theme.of(context).primaryColorLight,
              ),
            ),
          ],
        ),
      ),
      body: (_isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      // elevation: 4,
                      child: ListTile(
                        // leading:
                        title: Text(dataList[index].name.toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            const Icon(
                              Icons.car_rental_outlined,
                              color: Colors.black,
                              size: 70,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(dataList[index].lastValue.toString(),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // child: ListView.builder(
              //   // physics: AlwaysScrollableScrollPhysics(),
              //   itemCount: dataList.length,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 8.0, vertical: 4),
              //       child: Card(
              //         elevation: 4,
              //         child: ListTile(
              //           leading: Icon(Icons.car_rental),
              //           title: Text("Name: " + dataList[index].name.toString()),

              //           subtitle: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("Entered at: " +
              //                   dataList[index].createdAt.toString()),
              //               SizedBox(
              //                 height: 4,
              //               ),
              //               Text("xited at: " +
              //                   dataList[index].updatedAt.toString()),
              //               SizedBox(
              //                 height: 4,
              //               ),
              //               Text("Cars: " +
              //                   dataList[index].lastValue.toString()),
              //             ],
              //           ),
              //           // title: Text("Updated at: "+ dataList[index].updatedAt.toString()+" "+ "Name: "+ dataList[index].name.toString()),
              //           // subtitle: Text(dataList[index].createdAt.toString()),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
    );
  }
}
