import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aplicacion_serviceflow/core/theme/app_theme.dart';
import 'package:aplicacion_serviceflow/data/models/orden_servicio_model.dart';

class ServiceOrderCard extends StatelessWidget {
  final OrdenServicio orden;
  const ServiceOrderCard({super.key, required this.orden});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.go('/order/${orden.id}'),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orden.tipoServicio,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryDark),
              ),
              const SizedBox(height: 8),
              Text(orden.cliente, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      orden.direccion,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/navigation/${orden.id}'),
                  icon: const Icon(Icons.navigation_outlined),
                  label: const Text('Iniciar Ruta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}