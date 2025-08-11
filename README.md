# Neural-Network-Vs-Fuzzy-Systems
Exploring how fuzzy systems compare to Neural networks when approximating a non-linear control surface.
# Neural Network & Fuzzy System for Non-Linear Surface Approximation

This project compares two approaches for approximating a complex non-linear 3D control surface:
- A **Mamdani-type fuzzy logic controller**
- A **Fully Connected Cascade (FCC) neural network**

## Key Results
| Model                | MSE     | Training Time | Surface Quality |
|----------------------|---------|---------------|-----------------|
| Fuzzy System         | 0.96    | ~2s           | Blocky steps    |
| FCC Neural Network   | 0.0064  | ~15s          | Smooth curve    |


## Requirements
- MATLAB R2024b (or compatible version)
- Neural Network Toolbox (for FCC implementation)

## How to Run
1. **FuzzyController**:% Generates Mamdani fuzzy surface
2.**NEURALNETCONTROLLER**;  % Trains network and plots surface

## Files;
- **`FUZZYCONTROLLER.m`**: MATLAB implementation of fuzzy controller
- **`NEURALNETCONTROLLER.m`**: MATLAB implementation of neural network

## Report: 
My final report is capturing my full understanding and Methodology and references can be found in the 'Neural Network & Fuzzy Systems' pdf


NB; feel free to contribute  or share ideas geared towards improvements 


