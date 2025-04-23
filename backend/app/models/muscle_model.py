from app import db

class Muscle(db.Model):
    __tablename__ = 'muscles'

    id = db.Column(db.String(120), primary_key=True)
    name = db.Column(db.String(120), nullable=False)

    exercises = db.relationship('Exercise', back_populates='muscle')

    def __repr__(self):
        return f'<Muscle {self.name}>'