import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Set<Marker> _markers = {};
  _verifyLocale() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Serviço de Geolocalização não ativado.");
    }
    print("AQUI ativo");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Serviço não tem permissão de uso.");
      }
    }
    print("AQUI permissao");

    final localeMe = await Geolocator.getCurrentPosition();

    _markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(localeMe.latitude, localeMe.longitude),
      ),
    );
    setState(() {});

    print("Localização do Usuário");
    print(localeMe.latitude);
    print(localeMe.longitude);
  }

  @override
  void initState() {
    _verifyLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          markers: _markers,
          initialCameraPosition: CameraPosition(
              target: LatLng(-3.0889600106820794, -60.00426611537844),
              zoom: 12),
        ),
      ),
    );
  }
}
