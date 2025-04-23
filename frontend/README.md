## GymSnap - Flutter App

This is the frontend of the gym equipment classification app, built using Flutter. The app allows users to browse exercises, filter them by equipment and/or muscle groups while integrating with a backend API for data retrieval and image-based equipment predictions.

## Getting Started

### Prerequisites
Ensure you have the following installed:
- **Flutter SDK** (https://flutter.dev/docs/get-started/install)
- **Dart** (Included with Flutter)
- **Android Studio**
- **VS Code**

### Installation
Clone the repository and install dependencies:
```sh
# Clone the repo
git clone https://github.com/your-repo.git
cd frontend

# Install dependencies
flutter pub get
```

### Running the App
To start the app in debug mode:
```sh
flutter run
```

### Building for Production
To generate an APK:
```sh
flutter build apk
```
To generate an iOS build:
```sh
flutter build ios
```

## Project Structure
```
assets/                 # Static assets (images)
lib/
  api/                  # API client and services
  enums/                # Enum definitions
  models/               # Data models
  pages/                # UI pages
  services/             # Services
  utils/                # Utilities abd theme data
  widgets/              # Reusable UI components
  main.dart             # Application entry point
pubspec.yaml            # Dependencies and project configuration
```

## Link to the GitHub App Repository
[2024-25c-fai1-adsai-ErikHrina230395/App](https://github.com/BredaUniversityADSAI/2024-25c-fai1-adsai-ErikHrina230395/tree/main/App)