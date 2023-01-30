// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:example/page1.dart/CustomText.dart';
import 'package:example/page1.dart/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../Constants/CircleFrave.dart';
import '../models/sensor_data_model.dart';
import '../provider/themeprovider.dart';
// import 'package:smart_parking/pages/home_page.dart';

class ZoomDrawerTest extends StatefulWidget {
  const ZoomDrawerTest({Key? key}) : super(key: key);

  @override
  _ZoomDrawerTestState createState() => _ZoomDrawerTestState();
}

class _ZoomDrawerTestState extends State<ZoomDrawerTest> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.Style1,
      menuScreen: const MENU_SCREEN(),
      mainScreen: const HomePage(),
      borderRadius: 40.0,
      showShadow: true,
      angle: -12.0,
      // backgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 1,
      openCurve: Curves.easeIn,
      closeCurve: Curves.easeInOut,
    );
  }
}

class MENU_SCREEN extends StatefulWidget {
  const MENU_SCREEN({Key? key}) : super(key: key);

  @override
  _MENU_SCREENState createState() => _MENU_SCREENState();
}

class _MENU_SCREENState extends State<MENU_SCREEN> {
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
    final size = MediaQuery.of(context).size;
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 238, 238),
      // appBar: AppBar(
      //   // backgroundColor: Colors.white,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 226),
      //         child: IconButton(
      //           iconSize: 17,
      //           onPressed: () {
      //             themeProvider.toggleTheme();
      //           },
      //           // padding: EdgeInsets.all(10),
      //           icon: (themeProvider.themeMode == ThemeMode.light)
      //               ? Icon(Icons.dark_mode_rounded)
      //               : Icon(Icons.light_mode_rounded),
      //         ),
      //       ),
      //       Text(
      //         themeProvider.themeMode == ThemeMode.light
      //             ? "Light Mode"
      //             : "Dark Mode",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w500,
      //           fontSize: 15,
      //           color: themeProvider.themeMode == ThemeMode.light
      //               ? Theme.of(context).hintColor
      //               : Theme.of(context).primaryColorLight,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: (_isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: getData,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListView(
                      physics: const BouncingScrollPhysics(),
                      //  physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          top: 40.0, bottom: 0, left: 10, right: 0),
                      // padding: EdgeInsets.only(top: 35.0, bottom: 90.0),
                      children: [
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 0),
                            child: CircleFrave(
                              color: const Color.fromARGB(255, 20, 20, 20),
                              radius: 70,
                              child: Center(
                                  child: CustomText(
                                      text: "username"
                                          .substring(0, 2)
                                          .toUpperCase(),
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BounceInRight(
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomText(
                                      text: "Ram Bhandari",
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              FadeInRight(
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: "raambhandari78891@gmail.com",
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 100, 100, 100),
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ],
                          ),
                        ]),
                        const SizedBox(height: 26.0),
                        const Divider(
                          height: 10,
                          color: Color.fromARGB(255, 136, 119, 119),
                        ),
                        Container(
                          height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 243, 240, 240),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              CardProfile(
                                  color: Colors.white,
                                  text: 'About',
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(8.8),
                                      topLeft: Radius.circular(8.8),
                                      bottomRight: Radius.circular(8.8),
                                      topRight: Radius.circular(8.8)),
                                  backgroundColor: Color(0xff7E6B8F),
                                  icon: Icons.info,
                                  onPressed: () => () {}),
                              // _Divider(size: size),
                              const SizedBox(
                                height: 8,
                              ),
                              CardProfile(
                                color: Colors.black,
                                text: 'Add parking slot',
                                backgroundColor: Color(0xff118AB2),
                                icon: Icons.add_location_alt_sharp,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.8),
                                    topLeft: Radius.circular(8.8),
                                    bottomRight: Radius.circular(8.8),
                                    topRight: Radius.circular(8.8)),
                                onPressed: () => () {},
                              ),

                              const SizedBox(
                                height: 8,
                              ),
                              CardProfile(
                                color: Colors.black,
                                text: 'Nearest Parking Slot',
                                backgroundColor: Color(0xffEF476F),
                                icon: Icons.location_on,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.8),
                                    topLeft: Radius.circular(8.8),
                                    bottomRight: Radius.circular(8.8),
                                    topRight: Radius.circular(8.8)),
                                onPressed: () => () {},
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CardProfile(
                                color: Colors.black,
                                text: 'Slot Reservation',
                                backgroundColor: Color(0xff06D6A0),
                                icon: Icons.car_rental_rounded,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.8),
                                    topLeft: Radius.circular(8.8),
                                    bottomRight: Radius.circular(8.8),
                                    topRight: Radius.circular(8.8)),
                                onPressed: () => () {},
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          color: Colors.amber,
                          height: 10,
                          width: 40,
                          child: Column(
                            children: [
                              CardProfile(
                                color: Colors.black,
                                text: 'Log Out',
                                backgroundColor: Color(0xffEF476F),
                                icon: Icons.location_on,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.8),
                                    topLeft: Radius.circular(8.8),
                                    bottomRight: Radius.circular(8.8),
                                    topRight: Radius.circular(8.8)),
                                onPressed: () => () {},
                              ),
                            ],
                          ),
                        )
                      ]);
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

class _Divider extends StatelessWidget {
  final Size size;

  _Divider({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 65.0, right: 25.0),
      child: Container(
        height: 1,
        width: size.width,
        color: Colors.grey[300],
      ),
    );
  }
}

class CardProfile extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final IconData icon;

  CardProfile(
      {required this.text,
      required this.onPressed,
      required this.borderRadius,
      required this.backgroundColor,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 154, 150, 150),
          borderRadius: borderRadius),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 0.0,
        margin: EdgeInsets.all(0.0),
        child: InkWell(
          borderRadius: borderRadius,
          // onLongPress:Navigator.,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Icon(
                        icon,
                        color: Color.fromARGB(255, 237, 235, 235),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    CustomText(
                      text: text,
                      fontSize: 18,
                      color: Color.fromARGB(255, 58, 58, 58),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
