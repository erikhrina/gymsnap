# Backend Service

This is the backend for GymSnap. It provides APIs for a gym equipment classification application.

## API Endpoints Overview

| Method | Endpoint            | Description |
|--------|---------------------|-------------|
| GET    | `/getExercises`     | Retrieve a list of exercises, optionally filtered by equipment, muscle group, or search text. |
| GET    | `/getEquipment`     | Retrieve a list of available equipment. |
| GET    | `/getMuscleGroups`  | Retrieve a list of muscle groups. |
| GET    | `/getExerciseInfo`  | Get detailed information about a specific exercise. |
| GET    | `/getImage`         | Retrieve an image based on exercise, muscle, or equipment ID. |
| POST   | `/predict`          | Predict equipment based on an uploaded image. |


## Setup & Deployment with Docker

Follow these steps to build, run, and check the backend using Docker.

### **1. Build the Docker Image**
Navigate to the backend directory where the `Dockerfile` is located and run:

```sh
docker build -t gymsnap-backend .
```

This will create a Docker image named gymsnap-backend.

### **2. Run the Backend in a Container**
Start the container using:

```sh
docker run -d -p 5000:5000 --name backend-container gymsnap-backend
```

- -d → Runs in detached mode (background).

- -p 5000:5000 → Maps port 5000 on the host to port 5000 in the container.

- --name backend-container → Names the container backend-container.

### **3. Check if the Backend is Running**
To verify that the container is running, use:

```sh
docker ps
```

If the backend is not working correctly, check the logs:

```sh
docker logs backend-container
```