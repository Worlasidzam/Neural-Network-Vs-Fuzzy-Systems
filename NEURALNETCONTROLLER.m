clc; clear; close all;

%Training Data 
inputs = [0 0; 0 1; 0 2; 0 3; 0 4;
          1 0; 1 1; 1 2; 1 3; 1 4;
          2 0; 2 1; 2 2; 2 3; 2 4;
          3 0; 3 1; 3 2; 3 3; 3 4;
          4 0; 4 1; 4 2; 4 3; 4 4]';

outputs = [0.0556; 0.1847; 0.3366; 0.3366; 0.1847;
           0.1590; 0.5279; 0.9620; 0.9620; 0.5279;
           0.3366; 1.1177; 2.0366; 2.0366; 1.1177;
           0.5279; 1.7529; 3.1941; 3.1941; 1.7529;
           0.6134; 2.0366; 3.7110; 3.7110; 2.0366]';

% Creating the FCC Neural Network
net = cascadeforwardnet(6);  % 6 hidden neurons

% Configure training settings
net.trainFcn = 'trainlm';  % Levenberg-Marquardt
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-5;

% Split data
net.divideFcn = 'dividerand'; 
net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0.2;

% Train the network
[net, tr] = train(net, inputs, outputs);

% Evaluate on Grid 
[xg, yg] = meshgrid(linspace(0, 4, 30));
grid_input = [xg(:)'; yg(:)'];
z_flat = net(grid_input);
z_grid = reshape(z_flat, size(xg));

% Plot Output Surface
figure;
mesh(xg, yg, z_grid);
xlabel('x'); ylabel('y'); zlabel('z');
title('FCC Neural Network Controller Surface (6 Hidden Neurons)');

% Show Training Performance and MSE
predicted = net(inputs);
mse_val = mean((predicted - outputs).^2);
fprintf('Final MSE: %.6f\n', mse_val);

figure;
plotperform(tr);
