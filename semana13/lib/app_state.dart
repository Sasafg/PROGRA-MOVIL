import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _Lista = prefs.getStringList('ff_Lista') ?? _Lista;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _Lista = [];
  List<String> get Lista => _Lista;
  set Lista(List<String> _value) {
    _Lista = _value;
    prefs.setStringList('ff_Lista', _value);
  }

  void addToLista(String _value) {
    _Lista.add(_value);
    prefs.setStringList('ff_Lista', _Lista);
  }

  void removeFromLista(String _value) {
    _Lista.remove(_value);
    prefs.setStringList('ff_Lista', _Lista);
  }

  void removeAtIndexFromLista(int _index) {
    _Lista.removeAt(_index);
    prefs.setStringList('ff_Lista', _Lista);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
