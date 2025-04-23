import json
import sys
import os

# Add the project root directory to the module search path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import create_app, db
from app.models.exercise_model import Exercise
from app.models.muscle_model import Muscle
from app.models.equipment_model import Equipment

app = create_app()

def load_data():
    '''Function to load JSON data into the database'''
    with open('data/muscles.json') as muscle_file:
        muscle_data = json.load(muscle_file)

    with open('data/equipment.json') as equipment_file:
        equipment_data = json.load(equipment_file)    
    
    with open('data/exercises.json') as exercise_file:
        exercise_data = json.load(exercise_file)
    
    with app.app_context():
        for equipment in equipment_data:
            key = equipment['id']
            if not Equipment.query.filter_by(id=key).first():
                new_equipment = Equipment(
                    id=key,
                    name=equipment['name'].capitalize())
                db.session.add(new_equipment)
        
        for muscle in muscle_data:
            key = muscle['id']
            if not Muscle.query.filter_by(id=key).first():
                new_muscle = Muscle(
                    id=key,
                    name=muscle['name'].capitalize())
                db.session.add(new_muscle)

        for exercise in exercise_data:
            equipment = Equipment.query.filter_by(id=exercise['primary_equipment']).first()
            secondary_equipment = Equipment.query.filter_by(id=exercise['secondary_equipment'] if exercise['secondary_equipment'] else None).first()
            muscle = Muscle.query.filter_by(id=exercise['primary_muscle']).first()
            secondary_muscles = []

            if exercise['secondary_muscles']:
                for s_muscle in exercise['secondary_muscles']:
                    sec_muscle = Muscle.query.filter_by(id=s_muscle).first()
                    if sec_muscle:
                        secondary_muscles.append(sec_muscle)

            if equipment and muscle:
                if not Exercise.query.filter_by(id=exercise['id']).first():
                    new_exercise = Exercise(
                        id=exercise['id'],
                        name=exercise['name'].capitalize(),
                        description=' '.join(exercise['instructions']),
                        equipment_id=equipment.id,
                        secondary_equipment_id=secondary_equipment.id if secondary_equipment != None else None,
                        muscle_id=muscle.id,
                        level=exercise['level'],
                        secondary_muscles=secondary_muscles)
                    db.session.add(new_exercise)

        db.session.commit()
        print('Data loaded successfully!')

if __name__ == '__main__':
    load_data()