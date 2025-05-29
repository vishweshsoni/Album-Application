# 📱 Album Application

A modern Flutter application that displays albums and photos using the JSONPlaceholder API. Built with clean architecture principles and best practices.

![Flutter](https://img.shields.io/badge/Flutter-3.32.0-blue)
![Dart](https://img.shields.io/badge/Dart-3.8.0-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 🎯 Features

- 📸 View albums and photos
- 🔄 Infinite scrolling for albums and photos
- 🎨 Modern Material Design 3 UI
- 🌐 Offline support with local caching
- ⚡ Fast and responsive UI
- 🛠 Clean Architecture implementation
- 🧪 Unit and widget tests

## 🚀 Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [FVM (Flutter Version Management)](https://fvm.app/)
- [Git](https://git-scm.com/)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)

### FVM Setup

1. Install FVM:
```bash
dart pub global activate fvm
```

2. Install the required Flutter version:
```bash
fvm install 3.32.0
```

3. Configure the project to use the installed version:
```bash
fvm use 3.32.0
```

4. Verify the Flutter version:
```bash
fvm flutter --version
```

### Installation

1. Clone the repository:
```bash
git clone https://github.com/vishweshsoni/Album-Application.git
cd Album-Application
```

2. Get dependencies:
```bash
fvm flutter pub get
```

3. Run the app:
```bash
fvm flutter run
```

## 🏗 Project Structure

```
lib/
├── core/
│   ├── bloc_observer.dart
│   ├── constant/
│   ├── database/
│   ├── di/
│   ├── providers/
│   └── routes/
├── features/
│   ├── albums/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       └── presentation/
└── service/
```

## 🛠 Architecture

This project follows Clean Architecture principles:

- **Presentation Layer**: UI components, BLoC pattern
- **Domain Layer**: Business logic, entities, repositories interfaces
- **Data Layer**: Repository implementations, data sources

## 📦 Dependencies

- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - State management
- [freezed](https://pub.dev/packages/freezed) - Code generation for data classes
- [chopper](https://pub.dev/packages/chopper) - HTTP client
- [cached_network_image](https://pub.dev/packages/cached_network_image) - Image caching
- [get_it](https://pub.dev/packages/get_it) - Dependency injection
- [sqflite](https://pub.dev/packages/sqflite) - Local database

## 🧪 Testing

Run tests using:
```bash
fvm flutter test
```

## 📱 Screenshots

[Add your app screenshots here]

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Vishwesh Soni**
- GitHub: [@vishweshsoni](https://github.com/vishweshsoni)

## 🙏 Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for the API
- [Flutter](https://flutter.dev/) team for the amazing framework
- All the package authors that made this project possible

## 📥 Download

You can download the latest release APK from the [releases](releases) directory:
- [Album v1.0.0](releases/album-v1.0.0.apk)
