import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'data/error.dart';
import 'data/place_response.dart';
import 'data/result.dart';

class NearbyPage extends StatefulWidget {

  NearbyPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const String _API_KEY = 'AIzaSyCNd8D2Qc3pbqx7fDtjh2Eop09i3rZJrjA';
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Position position;
  Widget _child;
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Location location = new Location();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Location service is not enabled');
        return;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position res = await Geolocator.getCurrentPosition();
    searchNearby(res);
  }

  List<Marker> markers = <Marker>[];
  Error error;
  List<Result> places;
  bool searching = true;
  // Set<Marker> _createMarkers() {
  //   return <Marker> [
  //     Marker(
  //       markerId: MarkerId("Home"),
  //       position: LatLng(position.latitude, position.longitude),
  //       icon: BitmapDescriptor.defaultMarker,
  //       infoWindow: InfoWindow(title: "Home",),
  //     )
  //   ].toSet();
  // }

  void searchNearby(Position pos) async {
    setState(() {
      markers.clear();
    });
    double latitude = pos.latitude;
    double longitude = pos.longitude;
    String keyword = "vet";
    String url =
        '$baseUrl?key=$_API_KEY&location=$latitude,$longitude&radius=10000&keyword=$keyword';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data, pos);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
    print("hello");
  }

  void _handleResponse(data, Position pos){
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          String open_status = "Open";
          if (!places[i].opening_hours) {
            open_status = "Closed";
          }
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container (
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              title: Center(
                                child: Text(
                                  places[i].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.star,
                                color: shrinePink400,
                              ),
                              title: Text(places[i].rating.toString()),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: shrinePink400,
                              ),
                              title: Text(places[i].vicinity),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.access_time,
                                color: shrinePink400,
                              ),
                              title: Text(open_status),
                            ),
                          ],
                        ),
                      );
                    }
                );
              },
            ),
          );
        }
        position = pos;
        _child = _mapWidget();
      });
    } else {
      print(data);
    }
  }

  Widget _mapWidget() {
    return Stack(
      children: <Widget>[
        // Replace this container with your Map widget
        GoogleMap(
          mapType: MapType.normal,
          markers: Set<Marker>.of(markers),
          initialCameraPosition: CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 12,
              bearing: 15.0,
              tilt: 75.0
          ),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
        ),
        Positioned(
          top: 10,
          right: 15,
          left: 15,
          child: Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search..."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    splashColor: Colors.grey,
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nearby'),
          backgroundColor: shrinePink400,
        ),
        body: _child,
      );
  }
}

const Color shrinePink400 = Color(0xFFEAA4A4);