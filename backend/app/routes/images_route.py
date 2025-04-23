import os
from app.models.exercise_model import Exercise
from app.models.equipment_model import Equipment
from app.models.muscle_model import Muscle
from flask import Blueprint, request, send_file, jsonify

images_bp = Blueprint('images', __name__)

# Path to where images are stored locally
IMAGE_FOLDER = 'images'

@images_bp.route('/getImage', methods=['GET'])
def get_image():
    # Extract query parameters
    exercise_id = request.args.get('exercise_id')
    muscle_id = request.args.get('muscle_id')
    equipemnt_id = request.args.get('equipment_id')

    # Validate that exactly one parameter is provided
    params = [exercise_id, muscle_id, equipemnt_id]
    if sum(param is not None for param in params) != 1:
        return jsonify({
            "error": "Bad Request",
            "message": "Exactly one of 'exercise_id', 'muscle_id', or 'equipment_id' must be provided."
        }), 400
    
    # Determine the file to fetch based on the provided parameter
    file_name = None
    if exercise_id:
        file_name = f'exercises/{exercise_id}.jpg'
    elif muscle_id:
        file_name = f'muscles/{muscle_id}.jpg'
    elif equipemnt_id:
        file_name = f'equipment/{equipemnt_id}.jpg'

    # Full file path
    file_path = os.path.join(IMAGE_FOLDER, file_name)

    # Check if the file exists
    if not os.path.exists(file_path):
        return jsonify({
            "error": "Not Found",
            "message": "No image found for the specified criteria."
        }), 404
    
    # Return the image file
    return send_file(os.path.abspath(file_path), mimetype='image/png')