import os

class Config:
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = os.urandom(42)
    SQLALCHEMY_DATABASE_URI = 'sqlite:///local_database.db'