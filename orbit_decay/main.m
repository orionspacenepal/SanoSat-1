% Orbit decay prediction of SanoSat-1
% Rishav (2023-01-02)

clc
clear
close all

filename = 'sanosat1.txt';
[names, line1, line2] = read_tle(filename);

h = zeros(1, length(names));
t = zeros(1, length(names));

% Compute height from TLEs
for i = 1 : length(names)
  l1 = strsplit(line1{i});
  l2 = strsplit(line2{i});

  mu = 3.986004418e5; % m^3/s^2
  epoch = str2num(l1{4});
  t(i) = epoch2year(epoch);

  n = str2num(l2{8}) / 86400; % Mean motion, rev/s
  e = str2num(l2{5}) * 1e-7;  % Ecentricity

  a = (mu / (4 * pi^2 * n^2))^(1/3); % Semi-major axis
  h(i) = a * (1 + e) - 6371;
end

% Curve fit the hight profile
polyfit_degree = 70;
coeffs = polyfit(t, h, polyfit_degree);

% Extrapolate till threshold height
h_threshold = 100; % km
dt = 1/365; % Time increment, year
t_hat = t;

while (1)
  h_min = polyval(coeffs, t_hat(end) + dt);

  if(h_min >= h_threshold)
    t_hat = [t_hat, t_hat(end) + dt];
  else
    break
  end
end

% Time hwn threshold height is reached
dt = year2date(t_hat(end));
h_hat = polyval(coeffs, t_hat);
dt_str = strcat(num2str(dt(1)), '-', num2str(dt(2)), '-', num2str(dt(3)));

% Visualization
figure;
plot(t, h, '*', t_hat, h_hat, 'LineWidth', 2); hold on;
grid on;
title('Orbit decay prediction of SanoSat-1');
xlim([min(t_hat), max(t_hat)]);
xlabel({'Epoch time (year)', cstrcat("100 km height expected on ", dt_str)});
ylabel('Altitude, km');
legend('TLE', 'Prediction');
