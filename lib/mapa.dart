import 'package:app89/utils/get_api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late GoogleMapController mapController; //Variable para manipular el mapa
  late LatLng _center = const LatLng(22.144596, -101.009064);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDataJson();
  }

  //Inicializar y crear el mapa
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getDataJson() async {
    NetworkHelper nh = NetworkHelper(
      startLat: 22.144596,
      startLng: -101.009064,
      endLat: 22.149730,
      endLng: -100.992221,
    );

    try {
      var datos;
      datos = await nh.getData();
      print("Coordenadas: ${datos['features'][0]['geometry']['coordinates']}");
    } catch(e) {
      print('Hubo un error al extraer las coordenadas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated, //Crea el mapa
            myLocationEnabled: true, //detecta mi posición actual
            myLocationButtonEnabled: true, //muestra el botón para encontrar mi posicion
            initialCameraPosition: CameraPosition( //Coloca el centro del mapa
              target: _center, //en cierta posisción
              zoom: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
