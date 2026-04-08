%  TORQUE-SLIP CHARACTERISTIC OF 3-PHASE INDUCTION MOTOR
clc; clear; close all;

disp('====================================================');
disp('TORQUE-SLIP CHARACTERISTIC SIMULATOR');
disp('3-Phase Induction Motor');

% ====================== PARAMETERS ======================
s = linspace(0.001, 2, 500);        % Slip range (0 to 2)
X2 = 2.0;                           % Rotor reactance at standstill (Ω)
k  = 1.0;                           % Proportionality constant (normalize torque)

% Different rotor resistances
R2_values = [0.2, 0.5, 1.0, 2.0];
labels = {'Squirrel-cage (low R2)', 'Medium', 'Wound rotor', 'High R2'};

% ====================== PLOT ======================
figure('Position', [100 100 1200 700]);
hold on;
grid on;

colors = lines(length(R2_values));   % Nice distinct colors

for i = 1:length(R2_values)
    R2 = R2_values(i);
    
    % Torque equation from lecture notes
    T = k * (s .* R2) ./ (R2.^2 + (s .* X2).^2);
    
    plot(s, T, 'LineWidth', 2.5, 'Color', colors(i,:), ...
         'DisplayName', sprintf('%s (R₂ = %.2f Ω)', labels{i}, R2));
    
    % Maximum torque point
    s_m = R2 / X2;
    T_max = k * (s_m * R2) / (R2^2 + (s_m * X2)^2);
    plot(s_m, T_max, 'ro', 'MarkerSize', 9, 'LineWidth', 1.5);
    text(s_m + 0.04, T_max + 0.02, sprintf('T_max\ns_m=%.2f', s_m), ...
         'FontSize', 10, 'Color', 'red');
    
    % Starting torque (s=1)
    T_start = k * (1 * R2) / (R2^2 + (1 * X2)^2);
    plot(1, T_start, 'bo', 'MarkerSize', 9, 'LineWidth', 1.5);
    text(1.04, T_start + 0.015, sprintf('T_start=%.2f', T_start), ...
         'FontSize', 10, 'Color', 'blue');
end

% Add double-cage / deep-bar rotor (extra feature)
R2o = 3.0; X2o = 0.5;   % Outer cage
R2i = 0.3; X2i = 3.0;   % Inner cage
To = k * (s .* R2o) ./ (R2o.^2 + (s .* X2o).^2);
Ti = k * (s .* R2i) ./ (R2i.^2 + (s .* X2i).^2);
T_total = To + Ti;
plot(s, T_total, 'k--', 'LineWidth', 3.5, 'DisplayName', 'Double-cage Rotor (Total)');

% Final plot settings
title('Torque-Slip Characteristics of 3-Phase Induction Motor', ...
      'FontSize', 16, 'FontWeight', 'bold');
xlabel('Slip (s)', 'FontSize', 14);
ylabel('Torque (proportional)', 'FontSize', 14);
xlim([0 2]);
ylim([0 0.65]);
yline(0, '--k');
xline(1, '--', 'Starting Point (s=1)', 'LabelHorizontalAlignment','center', 'LineWidth', 1.2);

legend('Location', 'best', 'FontSize', 11);
grid on;

% Force MATLAB to show the figure
drawnow;
figure(gcf);

disp('✅ Torque-Slip Characteristic Plot generated successfully!');
disp('   • Red circles  = Maximum torque points');
disp('   • Blue circles = Starting torque (s=1)');
disp('   • Black dashed = Double-cage rotor');