from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from app.utils.model_loader import load_cnn

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    # Create the Flask app
    app = Flask(__name__)
    
    # Load configuration
    app.config.from_object('config.Config')

    # Load ML pipeline
    app.config['MODEL'] = load_cnn()

    # Initialize the db and migrate objects
    db.init_app(app)
    migrate.init_app(app, db)

    return app
