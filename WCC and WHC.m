clc; close all; clear all;

% Orbital Parameters and Constants
h_LEO = 470;                  % km
R_E = 6378;                   % km
sin_rho = R_E / (R_E + h_LEO);
rho = asin(sin_rho);
sigma = 5.670367e-8;          % W/m2K4
theta = 0;                    % nadir direction
PI = pi;                      % pi definition

% Coefficients of alluminium paint
alfa_sc = 0.805;  % Solar absorptivity
eps_t = 0.825;    % infrared emissivity
Qint_max = 2;   % 10% Max Power
Qint_min = 0.8;   % 10% Min Power

% Constants
qir_max = 258;                                        % max flux density of Earth IR emission W/m^2
Gs_max = 1376;                                        % Solar constant
a = 0.3;                                              % Albedo Coefficient
Ka = 0.657 + (0.54 * sin_rho) - (0.196 * sin_rho^2);  % corrective factor
qir_min = 216;                                        % min flux density of Earth IR emission W/m^2

% Spherical Approx
A_p = 0.03;       % m2 
A_p2 = 0.01;      % m2 
S_lat = 4 * A_p + 2 * A_p2;       % Lateral Area
R_sph = sqrt(S_lat/(4*PI));       % Radius
A_s = PI * R_sph^2;               % Circle Area

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WCH%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Thermal Equation for the Worst Case Hot:
%     Q_sun, Q_alb, Qir_max, Qint_max
% WCH: Q_sun + Q_alb + Qir_max + Qint_max = Q_em

Qsun = alfa_sc * Gs_max * A_s;  
Qalb = alfa_sc * a * Gs_max * 4 * A_s * 0.5 * (1-cos(rho)) * Ka;
Qir_max = eps_t * qir_max * 4 * A_s * 0.5 * (1-cos(rho));

Tmax = ((Qsun + Qalb + Qir_max + Qint_max) / (sigma * 4 * A_s * eps_t))^0.25;

Tmax_celsius = Tmax - 273.15;

fprintf('Temperature: Tmax = %.2f K | %.2f °C\n', Tmax, Tmax_celsius);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%WCC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Thermal Equation for the Worst Case Cold:
%    Qir_min, Qint_min
%  Qir_min + Qint_min = Q_em

Qir_min = eps_t * qir_min * 4 * A_s * 0.5 * (1-cos(rho));

Tmin = ((Qir_min + Qint_min) / (sigma * eps_t * A_s * 4))^0.25;

Tmin_celsius = Tmin - 273.15;

fprintf('Temperature: Tmin = %.2f K | %.2f °C\n', Tmin, Tmin_celsius);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
