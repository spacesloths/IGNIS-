clc; close all; clear all;

% Definition of constants
m = 0.34; 
cp = 896;
eps = 0.825; 
A_s = 0.035;
sigma = 5.670367e-8;          % W/m2K4
TE = 191.33; % Ambient temperature in Kelvin
tau = (m*cp)/(4*eps*sigma*A_s*TE^3); % cooling constant
%tau = 3.95e4;

% Definition of the differential function
diff_eq = @(t, T) (TE^4 - T^4) / (4 * tau * TE^3);

% Definition of integration time
tspan = [0 2100]; %  Time interval from 0 to 2100 seconds

% Initial condition
T0 = 312; % Initial temperature in Kelvin

% Solving the differential equation
[t, T] = ode45(diff_eq, tspan, T0);

% Plot of the result
figure;
plot(t, T);
xlabel('Time (s)');
ylabel('Temperature (K)');
title('Temperature evolution over time');
grid on;