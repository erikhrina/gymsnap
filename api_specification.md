# API Specification


## GET /getExercises
**Description:** This endpoint retrieves a list of exercises, optionally filtered by equipment ID, muscle group, or search text.

**Request:**
- *Method:* GET
- *URL:* /getExercises
- *Parameters:*
  - `equipment_id` (optional, string): Filters exercises by the associated equipment ID.
  - `muscle_id` (optional, string): Filters exercises by the associated muscle group ID.
  - `search_text` (optional, string): Searches exercises by name or description.

**Example Request:**
```
GET /getExercises?equipment_id="eq"&muscle_id="muscle"&search_text="squat"
```

**Response:**
- *200 OK*
  - **Description:** The request was successful, and the exercises list is returned based on the provided filters.
  - **Body (JSON):**
```JSON
[
  {
    "id": "exercise_1",
    "name": "exercise 1",
    "muscle_group": "muscle group",
  },
  {
    "id": "exercise_2",
    "name": "exercise 2",
    "muscle_group": "muscle group",
  }
]
```
  - **Fields:**
    - `id` (string): The unique identifier for the exercise.
    - `name` (string): The name of the exercise.
    - `muscle_group` (string): The name of the primary muscle group targeted by the exercise.
- *400 Bad Request*
  - **Description:** The request could not be understood or contains invalid parameters.
  - **Body (JSON):**
```JSON
{
  "error": "Bad Request",
  "message": "Invalid request."
}
```
- *404 Not Found*
  - **Description:** No exercises were found that match the provided filters.
  - **Body (JSON):**
```JSON
{
  "error": "Not found",
  "message": "No exercises found matching the criteria."
}
```
- *500 Internal Server Error*
  - **Description:** An error occurred on the server while processing the request.
  - **Body (JSON):**
```JSON
{
  "error": "Internal Server Error",
  "message": "An unexpected error occurred while retrieving exercises."
}
``` 


## GET /getEquipment
**Description:** This endpoint retrieves a list of equipment.

**Request:**
- *Method:* GET
- *URL:* /getEquipment
- *Parameters:* None

**Response:**
- *200 OK*
  - **Description:** The request was successful, and the equipment list is returned.
  - **Body (JSON):**
```JSON
[
  {
    "id": "equipment_1",
    "name": "equipment 1"
  },
  {
    "id": "equipment_2",
    "name": "equipment 2"
  }
]
```
  - **Fields:**
    - `id` (string): The unique identifier for the equipment.
    - `name` (string): The name of the equipment.
- *400 Bad Request*
  - **Description:** The request could not be understood or was missing required parameters.
  - **Body (JSON):**
```JSON
{
  "error": "Bad Request",
  "message": "Invalid request."
}
```
- *500 Internal Server Error*
  - **Description:** An error occurred on the server while processing the request.
  - **Body (JSON):**
```JSON
{
  "error": "Internal Server Error",
  "message": "An unexpected error occurred while retrieving exercises."
}
``` 


## GET /getMuscleGroups
**Description:** This endpoint retrieves a list of muscle groups.

**Request:**
- *Method:* GET
- *URL:* /getMuscleGroups
- *Parameters:* None

**Response:**
- *200 OK*
  - **Description:** The request was successful, and the muscles list is returned.
  - **Body (JSON):**
```JSON
[
  {
    "id": "muscle_group_1",
    "name": "muscle group 1"
  },
  {
    "id": "muscle_group_2",
    "name": "muscle group 2"
  }
]
```
  - **Fields:**
    - `id` (string): The unique identifier for the muscle group.
    - `name` (string): The name of the muscle group.
- *400 Bad Request*
  - **Description:** The request could not be understood or was missing required parameters.
  - **Body (JSON):**
```JSON
{
  "error": "Bad Request",
  "message": "Invalid request."
}
```
- *500 Internal Server Error*
  - **Description:** An error occurred on the server while processing the request.
  - **Body (JSON):**
```JSON
{
  "error": "Internal Server Error",
  "message": "An unexpected error occurred while retrieving exercises."
}
```


## GET /getExerciseInfo
**Description:** This endpoint retrieves a description of an exercise\

**Request:**
- *Method:* GET
- *URL:* /getExerciseInfo
- *Parameters:*
  - `exercise_id` (string): The unique identifier of the exercise.

**Example Request:**
```
GET /getExerciseInfo?exercise_id="exercise_2"
```

**Response:**
- *200 OK*
  - **Description:** The request was successful, and the exercise is returned.
  - **Body (JSON):**
```JSON
{
  "id": "exercise_2",
  "name": "exercise 2",
  "description": "description",
  "primary_equipment": "equipment",
  "secondary_equipment": "equipment 2",
  "target_muscle": "muscle group",
  "secondary_muscles": ["muscle group 2"],
  "level": "level",
}
```
  - **Fields:**
    - `id` (string): The unique identifier for the exercise.
    - `name` (string): The name of the exercise.
    - `description` (string): A brief explanation of the exercise.
    - `primary_equipment` (string): The name of the primary equipment required for the exercise.
    - `secondary_equipment` (string or null): The name of any secondary equipment required for the exercise.
    - `target_muscle` (string): The name of the primary muscle group targeted by the exercise.
    - `secondary_muscles` (array of strings or null): A list of names representing secondary muscle groups worked during the exercise.
    - `level` (string): The difficulty of the exercise.
- *400 Bad Request*
  - **Description:** The request could not be understood or contains invalid parameters.
  - **Body (JSON):**
```JSON
{
  "error": "Bad Request",
  "message": "Invalid request."
}
```
- *404 Not Found*
  - **Description:**  No exercise was found with the provided `exercise_id`.
  - **Body (JSON):**
```JSON
{
  "error": "Not found",
  "message": "Invalid or missing parameter: 'exercise_id'."
}
```
- *500 Internal Server Error*
  - **Description:** An error occurred on the server while processing the request.
  - **Body (JSON):**
```JSON
{
  "error": "Internal Server Error",
  "message": "An unexpected error occurred while retrieving exercise information."
}
``` 


## GET /getImage
**Description:** This endpoint retrieves an image based on an `exercise_id`, `muscle_id`, or `equipment_id`.

**Request:**
- *Method:* GET
- *URL:* /getImage
- *Parameters:*
  - `exercise_id` (string): The unique identifier of the exercise.
  - `muscle_id` (string): The unique identifier of the muscle group.
  - `equipment_id` (string): The unique identifier of the equipment.

**Example Request:**
```
GET /getImage?exercise_id="exercise_1"
```

**Example Request:**
```
GET /getImage?muscle_id="muscle_group_1"
```

**Example Request:**
```
GET /getImage?equipment_id="equipment_1"
```

**Response:**
- *200 OK*
  - **Description:** The request was successful, and the image is returned as raw data.
  - **Headers:**
    - `Content-Type:` `image/png`.
    - `Content-Length:` [size of the image in bytes].
  - **Body:** The raw bytes of the image file.
- *400 Bad Request*
  - **Description:** The request could not be understood or contains invalid parameters.
  - **Body (JSON):**
```JSON
{
  "error": "Bad Request",
  "message": "Exactly one of 'exercise_id', 'muscle_id', or 'equipment_id' must be provided."
}
```
- *404 Not Found*
  - **Description:**  No exercise was found with the provided `exercise_id`.
  - **Body (JSON):**
```JSON
{
  "error": "Not found",
  "message": "No image found for the specified criteria."
}
```
- *500 Internal Server Error*
  - **Description:** An error occurred on the server while processing the request.
  - **Body (JSON):**
```JSON
{
  "error": "Internal Server Error",
  "message": "An unexpected error occurred while retrieving the image."
}
```


## POST /predict
**Description:** This endpoint retrieves an equipment based on the model's prediction of an image.

**Request:**
- *Method:* POST
- *URL:* /predict
- *Headers:* 
  - `Content-Type`: `multipart/form-data`
- *Body Parameters:*
  - `image` (file, required): The image file to be analyzed for equipment prediction.

**Response:**
- *200 OK*
  - **Description:** The request was successful, and the equipment was predicted based on the provided image.
  - **Body (JSON):**
```JSON
{
  "id": "equipment_n",
  "name": "equipment name"
}
```
  - **Fields:**
    - `id` (string): The unique identifier for the equipment.
    - `name` (string): The name of the equipment.
- *400 Bad Request*
  - **Description:** The request is malformed or missing the required image file.
  - **Body (JSON):**
```JSON
{
  "error": "Bad Request",
  "message": "A valid image file must be provided in the 'image' field."
}
```
- *422 Unprocessable Entity*
  - **Description:** The server could not process the image (e.g., invalid format, corrupted file).
  - **Body (JSON):**
```JSON
{
  "error": "Unprocessable Entity",
  "message": "The provided image could not be processed."
}
```
- *500 Internal Server Error*
  - **Description:** An error occurred on the server while processing the image or performing the prediction.
  - **Body (JSON):**
```JSON
{
  "error": "Internal Server Error",
  "message": "An unexpected error occurred while processing the prediction."
}
``` 