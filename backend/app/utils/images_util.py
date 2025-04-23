
import cv2
import numpy as np

ALLOWED_EXTENSIONS = {'jpg'}

def allowed_file(filename):
    """ Utility function to check allowed file types. """
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def cv2ConvertImage(file) :
    """ Converts image using OpenCV. """
    file_bytes = np.frombuffer(file.read(), np.uint8)
    return cv2.imdecode(file_bytes, cv2.IMREAD_COLOR)

def preprocess_and_convert_to_jpg(image):
    """
    Converts an image to JPEG format in memory and preprocess it for deep learning.

    Args:
        image (numpy.ndarray): The image.
        target_size (tuple): Desired image size (width, height).
        normalize (bool): Whether to normalize pixel values to [0, 1].

    Returns:
        numpy.ndarray: Preprocessed image array in JPEG format.
    """
    image = cv2ConvertImage(image)
    # Encode the image as JPEG in memory
    success, encoded_image = cv2.imencode('.jpg', image)
    if not success:
        raise ValueError("Failed to encode image to JPEG format.")

    # Decode it back to NumPy array
    image = cv2.imdecode(encoded_image, cv2.IMREAD_COLOR)

    # If the image has 4 channels, drop the alpha channel
    if image.shape[2] == 4:
        image = image[:, :, :3]

    # Resize image to the target size
    image = cv2.resize(image, (256, 256))

    # Add batch dimension
    image = np.expand_dims(image, axis=0)

    return image