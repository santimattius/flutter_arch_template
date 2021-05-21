# Flutter App Template
[![codecov](https://codecov.io/gh/santimattius/flutter_arch_template/branch/master/graph/badge.svg?token=4BXJWN2QVC)](https://codecov.io/gh/santimattius/flutter_arch_template) [![travis](https://travis-ci.com/santimattius/flutter_arch_template.svg?token=P7xvicFZMo2reEHHNuJS&branch=master)](https://travis-ci.com/santimattius/flutter_arch_template)

Este proyecto es un template de una app en flutter utilizando clean architecture.

A continuacion se describe la arquitectura de la app, estructurea del proyecto y las dependencias utilizadas.

<p align="left">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/feature/style_by_platform/screenshoot/flutter_ios_android.png?raw=true" alt="Project packages"/>
</p>

# Arquitectura de la app

<p align="left">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/feature/style_by_platform/screenshoot/flutter_clean_arch.png?raw=true" alt="Project packages"/>
</p>

## Estructura del proyecto

<p align="left">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/feature/readme/screenshoot/flutter_package_structure.png?raw=true" alt="Project packages"/>
</p>

## Dependencias
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
- [Flutter DOC](https://flutter.dev/docs)
- [Dart packages](https://pub.dev/)
