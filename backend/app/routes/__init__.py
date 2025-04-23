from .exercises_route import exercises_bp
from .equipment_route import equipment_bp
from .muscles_route import muscles_bp
from .images_route import images_bp
from .prediction_route import prediction_bp

def register_routes(app):
    '''Register each blueprint.'''
    app.register_blueprint(exercises_bp)
    app.register_blueprint(equipment_bp)
    app.register_blueprint(muscles_bp)
    app.register_blueprint(images_bp)
    app.register_blueprint(prediction_bp)