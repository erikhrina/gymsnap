from flask import Blueprint, jsonify
from app.models.equipment_model import Equipment

equipment_bp = Blueprint('equipment', __name__)

@equipment_bp.route('/getEquipment', methods=['GET'])
def get_equipment():
    try:
        # Retrieve all equipment entries
        equipment_list = Equipment.query.all()

        # Prepare the response
        response = sorted([{
            "id": eq.id,
            "name": eq.name.title()
            } for eq in equipment_list],
            key=lambda x: x['name']
        )

        return jsonify(response), 200
    except Exception as e:
        return jsonify({
            "error": "Internal Server Error",
            "message": f"An unexpected error occured: {str(e)}"
        }), 500