import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'places.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      primarySwatch: Colors.orange,

      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    initApp();

  }

  GoogleMapController mapController;

  Future<void> onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void initApp() {
    Location _location = Location.instance;

    _location.hasPermission().then((value) {
      if (value == PermissionStatus.granted) {
        //our app already has location permission
        haveLocationPermission(_location);
      } else {
        //doesn't have the permission
        //ask user the location permissions
        _location.requestPermission().then((value) {
          if (value == PermissionStatus.granted) {
            //now we have location permission
            haveLocationPermission(_location);
          } else {
           print('No location');
          }
        });
      }
    }).catchError((e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    });
  }

  void haveLocationPermission(Location _location) {
    _location.serviceEnabled().then((value) {
      if (value) {
        //service is enable, continue using it
        print(' location Access');
      } else {
        //ask for turning on the location
        _location.requestService().then((value) => {
          if (value)
            {
              //service is turned on now can continue using the map or location
              print(' location Access')
            }
          else
            {
             print('No location Access')
            }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(Icons.directions),
          splashColor: Colors.red,
          onPressed: (){

            gotoLocation(0,0,1);
          },
        ),
        title: Center(child: Text('Locato',
        style: TextStyle(
          fontFamily: 'Dancing',
        ),)),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
                child: buildGoogleMap()
            ),
            
//             DraggableScrollableSheet(
//               builder: (context, scrollcontroller) {
//                 return ListView(
//                     controller: scrollcontroller,
//                     children: <Widget>[
//                       box(p1.lat, p1.lon, p1.zoom, p1.img, p1.name, p1.cap),
//                       SizedBox(
//                         height: 10,
//                         width: 10,),
//                       box(p2.lat, p2.lon, p2.zoom, p2.img, p2.name, p2.cap),
//                       SizedBox(
//                         height: 10,
//                         width: 10,),
//                       box(p3.lat, p3.lon, p3.zoom, p3.img, p3.name, p3.cap),
//                       SizedBox(
//                         height: 10,
//                         width: 10,),
//                       box(p4.lat, p4.lon, p4.zoom, p4.img, p4.name, p4.cap),
//                       SizedBox(
//                         height: 10,
//                         width: 10,),
//                       box(p5.lat, p5.lon, p5.zoom, p5.img, p5.name, p5.cap),
//                       SizedBox(
//                         height: 10,
//                         width: 10,),
//                       box(p6.lat, p6.lon, p6.zoom, p6.img, p6.name, p6.cap),
//                     ]
//
//                 );
//               }
//              ),
      ]
            )

        ),

    );
  }
//  var currentLocation;
//
//  _getLocation() async {
//    var location = new Location();
//    try {
//       currentLocation = await location.getLocation();
//
//      print("locationLatitude: ${currentLocation["latitude"]}");
//      print("locationLongitude: ${currentLocation["longitude"]}");
//      setState(
//              () {}); //rebuild the widget after getting the current location of the user
//    } on Exception {
//      currentLocation = null;
//    }
//  }

  Widget buildGoogleMap() {
    final _initialMapPosition =
    CameraPosition(target: LatLng(0, 0), zoom: 1);

    return GoogleMap(
      initialCameraPosition: _initialMapPosition,
      onMapCreated: onMapCreated,
      myLocationEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      markers: {
        mark1,mark2,mark3,mark4,mark5,mark6
      },
    );
  }

  Widget gotoLocation(double lat,double lon,double zoom){
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat,lon),zoom: zoom, tilt: 10)
    ));
  }

  Marker mark1= Marker(
    markerId: MarkerId('0'),
    position: LatLng(28.5066,77.1749),
    infoWindow: InfoWindow(title: 'Chattarpur'),
  );
  Marker mark2= Marker(
    markerId: MarkerId('1'),
    position: LatLng(52.3667,4.8945),
    infoWindow: InfoWindow(title: 'Amsterdam'),
  );
  Marker mark3= Marker(
    markerId: MarkerId('2'),
    position: LatLng(36.7783,-119.4179,),
    infoWindow: InfoWindow(title: 'California'),
  );
  Marker mark4= Marker(
    markerId: MarkerId('3'),
    position: LatLng(40.4637,-3.7492),
    infoWindow: InfoWindow(title: 'Spain'),
  );
  Marker mark5= Marker(
    markerId: MarkerId('4'),
    position: LatLng(-25.2744, 133.7751),
    infoWindow: InfoWindow(title: 'Australia'),
  );
  Marker mark6= Marker(
    markerId: MarkerId('5'),
    position: LatLng(51.5074,-0.1278),
    infoWindow: InfoWindow(title: 'London'),
  );

  Widget box(double la, double lo, double z, AssetImage im, String n, String c){
    return Align(
        alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: (){
          gotoLocation(la,lo,z);
          print(la);
        },
      child: Container(

        padding: EdgeInsets.only(bottom: 30),
        height: 100,
        width: 200,
        child:
            FittedBox(

                child: Row(
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 20,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: CircleAvatar(backgroundImage: im,
                        radius: 3,),
                      ),

                    ),
                    Container(
                        height: 20,
                        width: 40,
                        color: Colors.white,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(n,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 7
                            ),
                            ),
                            Text(c,
                            style: TextStyle(
                              fontSize: 5,
                              fontFamily: 'Dancing'
                            ),)
                          ],
                           )
                        ),
                      ),
                    ])
                ),
            )

      ),

    );
  }

  Places p1=Places(la: 28.5066,lo:77.1749,z: 8, im: AssetImage('assets/sar.jpg'), n: 'SACHIN', c: 'Kuch nahi ghar pe bethe hai' );
  Places p2=Places(la: 52.3667,lo:4.8945,z: 8, im: AssetImage('assets/ritik.jpeg'), n: 'RITIK', c: 'Ladki ke peeche Amsterdam' );
  Places p3=Places(la: 36.7783,lo:-119.4179,z: 8, im: AssetImage('assets/mota.jpg'), n: 'ANMOL', c: 'Google mein job karte hue' );
  Places p4=Places(la: 40.4637,lo:-3.7492,z: 8, im: AssetImage('assets/tushar.jpg'), n: 'TUSHAR', c: 'Spain mein CIPL shuru kardia' );
  Places p5=Places(la: -25.2744,lo: 133.7751,z: 8, im: AssetImage('assets/ytagi.jpeg'), n: 'RISHAB', c: 'Australia mein Business Expanded' );
  Places p6=Places(la: 51.5074,lo:-0.1278,z: 8, im: AssetImage('assets/me4.jpeg'), n: 'PIYUSH', c: 'London Pohuch gya apun' );
}