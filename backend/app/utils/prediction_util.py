import numpy as np

label_mapping = {'bench': 0, 'dumbbells': 1, 'chest_press': 2, 'leg_press': 3}

def getLabelFromPrediction(prediction) :
    # Reverse the label mapping dictionary
    reverse_label_mapping = {v: k for k, v in label_mapping.items()}

    # Convert softmax predictions to class indices
    predicted_index = np.argmax(prediction, axis=1)[0]

    # Map class indices back to labels
    predicted_label = reverse_label_mapping[predicted_index]

    return predicted_label