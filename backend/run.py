from app import create_app
from app.routes import register_routes

app = create_app()

if __name__ == '__main__':
    # Register all routes via the register_routes function
    register_routes(app)
    # Run the application in debug mode
    app.run(host='0.0.0.0', port=5000, debug=True)