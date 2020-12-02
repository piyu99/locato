import 'package:flutter/cupertino.dart';

class Places {
  double lat;
  double lon;
  double zoom;
  AssetImage img;
  String name;
  String cap;

  Places({double la, double lo, double z, AssetImage im, String n, String c}){
    lat=la;
    lon=lo;
    img=im;
    name=n;
    zoom=z;
    cap=c;
}
}