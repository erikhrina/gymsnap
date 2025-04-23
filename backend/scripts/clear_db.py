import os, sys
# Add the project root directory to the module search path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import create_app, db
from app.models.exercise_model import Exercise
from app.models.muscle_model import Muscle
from app.models.equipment_model import Equipment

app = create_app()

def clear_database():
    with app.app_context():
        # Clear all records from each table
        db.session.query(Exercise).delete()
        db.session.query(Muscle).delete()
        db.session.query(Equipment).delete()
        # Add any other models you want to clear
        db.session.commit()

    print('Database cleared successfully!')

if __name__ == '__main__':
    clear_database()
