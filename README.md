# GymSnap

GymSnap is a mobile application designed for effective gym equipment classification. The app enables users to browse exercises, filter them by equipment and muscle groups, and integrates with a backend API for data retrieval and image-based equipment predictions.

## Features
- Browse exercises with filtering by equipment and muscle groups.
- View detailed information about exercises, including images.
- Predict equipment type based on uploaded images.

---

## API Endpoints Overview

| Method | Endpoint            | Description |
|--------|---------------------|-------------|
| GET    | `/getExercises`     | Retrieve a list of exercises, optionally filtered by equipment, muscle group, or search text. |
| GET    | `/getEquipment`     | Retrieve a list of available equipment. |
| GET    | `/getMuscleGroups`  | Retrieve a list of muscle groups. |
| GET    | `/getExerciseInfo`  | Get detailed information about a specific exercise. |
| GET    | `/getImage`         | Retrieve an image based on exercise, muscle, or equipment ID. |
| POST   | `/predict`          | Predict equipment based on an uploaded image. |

---

## Backend

The backend serves as the API layer for the GymSnap app, handling data retrieval, image-based predictions, and other core services.

### Setup & Deployment with Docker

Follow these steps to build, run, and check the backend using Docker:

#### **1. Build the Docker Image**
Navigate to the backend directory where the `Dockerfile` is located and run:

```sh
docker build -t gymsnap-backend backend/
```

This will create a Docker image named `gymsnap-backend`.

#### **2. Run the Backend in a Container**
Start the container using:

```sh
docker run -d -p 5000:5000 --name backend-container gymsnap-backend
```

- `-d`: Runs in detached mode (background).
- `-p 5000:5000`: Maps port 5000 on the host to port 5000 in the container.
- `--name backend-container`: Names the container `backend-container`.

#### **3. Check if the Backend is Running**
To verify that the container is running, use:

```sh
docker ps
```

If the backend is not working correctly, check the logs:

```sh
docker logs backend-container
```

---

## Frontend

The frontend is a Flutter-based mobile application that interacts with the backend API to provide a seamless user experience.

### Prerequisites
Ensure you have the following installed:
- **Flutter SDK** ([Installation Guide](https://flutter.dev/docs/get-started/install))
- **Dart** (Included with Flutter)
- **Android Studio**
- **VS Code**

### Installation
Clone the repository and install dependencies:

```sh
git clone https://github.com/erikhrina/gymsnap.git
cd frontend

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

---

## Project Structure

```
backend/                # Backend code and Dockerfile
frontend/               # Frontend Flutter application
  assets/               # Static assets (images)
  lib/
    api/                # API client and services
    enums/              # Enum definitions
    models/             # Data models
    pages/              # UI pages
    services/           # Services
    utils/              # Utilities and theme data
    widgets/            # Reusable UI components
  pubspec.yaml          # Dependencies and project configuration
  main.dart             # Application entry point
```

---