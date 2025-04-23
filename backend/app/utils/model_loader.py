from keras.models import load_model

def load_cnn():
    """Loads the model"""
    return load_model('app/model/cnn.h5')