import sys
import os

# Add the project root directory to the module search path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from flask import Blueprint, request, jsonify, current_app
from app.models.equipment_model import Equipment
import app.utils.images_util as im_util
from app.utils.prediction_util import getLabelFromPrediction

prediction_bp = Blueprint('predict', __name__)

@prediction_bp.route('/predict', methods=['POST'])
def predict():
    # Check if a file is provided
    if 'image' not in request.files:
        return jsonify({
            "error": "Bad Request",
            "message": "A valid image file must be provided in the 'image' field."
        }), 400
    
    file = request.files['image']

    # Validate the file
    if file.filename == '':
        return jsonify({
            "error": "Bad Request",
            "message": "No file selected."
        }), 400
    if not im_util.allowed_file(file.filename):
        return jsonify({
            "error": "Unsupported Media Type",
            "message": "File type not allowed. Please upload a JPG file."
        }), 415
    
    try:
        # Preprocess the image
        image = im_util.preprocess_and_convert_to_jpg(file)
    
        # Access the cnn model from app config
        model = current_app.config['MODEL']

        # Get the prediction
        prediction = model.predict(image)

        # Convert the prediction to a label
        equipment_id = getLabelFromPrediction(prediction)

        # Query for the Equipment object
        equipment = Equipment.query.filter_by(id=equipment_id).first()        

        # Return the prediction result (DUMMY)
        return jsonify({
            "id": equipment.id,
            "name": equipment.name.title()
        }), 200
    except Exception as e:
        print('ERROR:', str(e))
        return jsonify({
            "error": "Internal Server Error",
            "message": f"An unexpected error occured: {str(e)}"
        }), 500