# Flutter App Template
[![codecov](https://codecov.io/gh/santimattius/flutter_arch_template/branch/master/graph/badge.svg?token=4BXJWN2QVC)](https://codecov.io/gh/santimattius/flutter_arch_template) [![travis](https://travis-ci.com/santimattius/flutter_arch_template.svg?token=P7xvicFZMo2reEHHNuJS&branch=master)](https://travis-ci.com/santimattius/flutter_arch_template)

This project is a template of an app in flutter using clean architecture.

The following describes the architecture of the app, the structure of the project and the dependencies used.

<p align="center">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/master/screenshoot/flutter_ios_android.png?raw=true" alt="Project packages"/>
</p>

# Application architecture

<p align="center">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/master/screenshoot/flutter_clean_arch.png?raw=true" alt="Project packages"/>
</p>

## Project structure

<p align="left">
  <img src="https://github.com/santimattius/flutter_arch_template/blob/master/screenshoot/flutter_package_structure.png?raw=true" alt="Project packages"/>
</p>

## Packages
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
## References

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Clean Code](https://blog.cleancoder.com/)
- [Flutter Documentation](https://flutter.dev/docs)
- [Dart packages](https://pub.dev/)
