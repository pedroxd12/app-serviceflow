import 'package:flutter/material.dart';
import 'package:aplicacion_serviceflow/data/models/orden_servicio_model.dart';
import 'package:aplicacion_serviceflow/data/repositories/orden_servicio_repository.dart';
import 'package:aplicacion_serviceflow/design/widgets/common/loading_logo_animation.dart';
import 'package:aplicacion_serviceflow/design/widgets/home/service_order_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<OrdenServicio>> _ordenesFuture;
  final OrdenServicioRepository _repository = OrdenServicioRepository();

  @override
  void initState() {
    super.initState();
    _ordenesFuture = _repository.getOrdenesDelDia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades de Hoy'),
      ),
      body: FutureBuilder<List<OrdenServicio>>(
        future: _ordenesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingLogoAnimation(size: 100));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay actividades para hoy.'));
          }
          final ordenes = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _ordenesFuture = _repository.getOrdenesDelDia();
              });
            },
            child: ListView.builder(
              itemCount: ordenes.length,
              itemBuilder: (context, index) {
                return ServiceOrderCard(orden: ordenes[index]);
              },
            ),
          );
        },
      ),
    );
  }
}