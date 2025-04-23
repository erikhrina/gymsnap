from flask import Blueprint, jsonify
from app.models.muscle_model import Muscle

muscles_bp = Blueprint('muscles', __name__)

@muscles_bp.route('/getMuscleGroups', methods=['GET'])
def get_muscle_groups():
    try:
        # Retrieve all muscle group entries
        muscle_groups = Muscle.query.all()

        # Prepare the response
        response = sorted([{
            "id": muscle.id,
            "name": muscle.name.title()
            } for muscle in muscle_groups],
            key=lambda x: x['name']
        )

        return jsonify(response), 200
    except Exception as e:
        return jsonify({
            "error": "Internal Server Error",
            "message": f"An unexpected error occured: {str(e)}"
        }), 500