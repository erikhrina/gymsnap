from app import db

secondary_muscle_association = db.Table(
    'secondary_muscle_association',
    db.Column('exercise_id', db.String(120), db.ForeignKey('exercises.id'), primary_key=True),
    db.Column('muscle_id', db.String(120), db.ForeignKey('muscles.id'), primary_key=True)
)

class Exercise(db.Model):
    __tablename__ = 'exercises'

    id = db.Column(db.String(120), primary_key=True)
    name = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(500), nullable=True)
    equipment_id = db.Column(db.String(120), db.ForeignKey('equipment.id'), nullable=False)
    secondary_equipment_id = db.Column(db.String(120), db.ForeignKey('equipment.id'), nullable=True)
    muscle_id = db.Column(db.String(120), db.ForeignKey('muscles.id'), nullable=False)
    level = db.Column(db.String(120), nullable=True)

    primary_equipment = db.relationship(
        'Equipment',
        foreign_keys=[equipment_id],
        back_populates='primary_exercises')
    secondary_equipment = db.relationship(
        'Equipment',
        foreign_keys=[secondary_equipment_id],
        back_populates='secondary_exercises')

    muscle = db.relationship('Muscle', back_populates='exercises')

    secondary_muscles = db.relationship(
        'Muscle',
        secondary=secondary_muscle_association,
        backref=db.backref('exercises_with_secondary', lazy='dynamic')
    )

    def __repr__(self):
        return f'<Exercise {self.name}>'