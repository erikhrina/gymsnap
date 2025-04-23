from flask import Blueprint, request, jsonify
from app.models.exercise_model import Exercise
from app.models.equipment_model import Equipment
from app.models.muscle_model import Muscle

exercises_bp = Blueprint('exercises', __name__)

@exercises_bp.route('/getExercises', methods=['GET'])
def get_exercises():
    # Extract query parameters
    search_text = request.args.get('search_text')
    equipment_id = request.args.get('equipment_id')
    muscle_id = request.args.get('muscle_id') 

    # Base query
    query = Exercise.query

    # Filtier by equipment_id if provided
    if equipment_id is not None:
        query = query.filter(
            (Exercise.equipment_id == equipment_id) |
            (Exercise.secondary_equipment_id == equipment_id)
        )

    # Filter by muscle_id if provided
    if muscle_id is not None:
        query = query.filter(Exercise.muscle_id == muscle_id)

    # Filter by search_text if provided
    if search_text:
        query = query.filter(Exercise.name.ilike(f'%{search_text}%'))

    try:
        # Execute the query
        exercises = query.all()    

        # Prepare the response
        response = sorted(
            [{
            "id": exercise.id,
            "name": exercise.name.title(),
            "muscle_group": Muscle.query.filter_by(id=exercise.muscle_id).first().name,
            } for exercise in exercises], 
            key=lambda x: x['name']
        )

        # Return the response
        return jsonify(response), 200
    except Exception as e:
        return jsonify({
            "error": "Internal Server Error",
            "message": f"An unexpected error occured: {str(e)}"
        }), 500

@exercises_bp.route('/getExerciseInfo', methods=['GET'])
def get_exercise_info():
    # Extract query parameter
    exercise_id = request.args.get('exercise_id')

    # Validate that exercise_id is provided
    if not exercise_id:
        return jsonify({
            "error": "Bad Request",
            "message": "Missing parameter: 'exercise_id'."
        }), 400
    
    try:
        # Retrieve the exercise by ID
        exercise = Exercise.query.filter_by(id=exercise_id).first()

        if not exercise:
            return jsonify({
            "error": "Not Found",
            "message": "No exercise found with the provided 'exercise_id'."
        }), 404

        # Build the response data
        response = {
            "id": exercise.id,
            "name": exercise.name,
            "description": exercise.description,
            "primary_equipment": Equipment.query.filter_by(id=exercise.equipment_id).first().name,
            "secondary_equipment": Equipment.query.filter_by(id=exercise.secondary_equipment_id).first().name if exercise.secondary_equipment_id else None,
            "target_muscle": Muscle.query.filter_by(id=exercise.muscle_id).first().name,
            "secondary_muscles": [Muscle.query.filter_by(id=muscle.id).first().name for muscle in exercise.secondary_muscles or []],
            "level": exercise.level
        }

        # Return the response
        return jsonify(response), 200
    except Exception as e:
        return jsonify({
            "error": "Internal Server Error",
            "message": f"An unexpected error occured: {str(e)}"
        }), 500