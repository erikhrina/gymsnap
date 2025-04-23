from app import db

class Equipment(db.Model):
    __tablename__ = 'equipment'

    id = db.Column(db.String(120), primary_key=True)
    name = db.Column(db.String(120), nullable=False)

    primary_exercises = db.relationship(
        'Exercise', 
        foreign_keys='Exercise.equipment_id')
    secondary_exercises = db.relationship(
        'Exercise', 
        foreign_keys='Exercise.secondary_equipment_id')


    def __repr__(self):
        return f'<Equipment {self.name}>'