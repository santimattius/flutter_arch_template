# Flutter App Template

# Arquitectura de la app

## General

## Capas(Layers)

## Paquetes (Packages)

<p align="left">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/feature/readme/screenshoot/flutter_package_structure.png?raw=true" alt="Project packages"/>
</p>

## Librerías (Dependencies)
```yaml
dependencies:
  flutter:
    sdk: flutter
  # Service locator
  get_it: ^7.1.3
  # Bloc for state management
  flutter_bloc: ^7.0.0
  # Value equality
  equatable: ^2.0.0
  # Functional programming thingies
  dartz: ^0.9.2
  # Remote API
  data_connection_checker: ^0.3.4
  http: ^0.13.3
  # Local cache
  shared_preferences: ^2.0.5
  # Cache Image widget
  cached_network_image: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.0.7
  bloc_test: ^8.0.0
```
## Referencias

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Clean Code](https://blog.cleancoder.com/)
