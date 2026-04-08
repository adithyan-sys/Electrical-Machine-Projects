% =====================================================
%  SIMPLE LOOP GENERATOR WAVEFORM SIMULATOR


clc; clear; close all;

disp('====================================================');
disp('SIMPLE LOOP GENERATOR WAVEFORM SIMULATOR');
disp('MATLAB Version - Lecture Notes Based');
disp('====================================================');

% ====================== USER INPUTS ======================
Em = input('Enter Maximum Induced EMF Em (V) [e.g. 10]: ');
f  = input('Enter Frequency of rotation (Hz) [e.g. 1]: ');

omega = 2 * pi * f;

% Time for two full rotations (clear view of waveform)
t = linspace(0, 2, 1000);          % 2 seconds = two rotations
theta = omega * t;

% ====================== CALCULATIONS ======================
e_coil       = Em * sin(theta);                    % Alternating EMF (slip rings)
e_commutator = Em * abs(sin(theta));               % Rectified output (split-ring commutator)

% Key positions (0°, 45°, 90°, ..., 360°)
positions_deg = [0, 45, 90, 135, 180, 225, 270, 315, 360];
positions_rad = deg2rad(positions_deg);
t_pos = positions_deg / 360 * 2;                   % Time corresponding to angle

disp(' ');
disp('====================================================');
disp('RESULTS');
disp('====================================================');
fprintf('Maximum EMF (Em)          = %.2f V\n', Em);
fprintf('Frequency of rotation     = %.2f Hz\n', f);
fprintf('Coil EMF                  = Em × sin(θ)     → ALTERNATING\n');
fprintf('After Commutator          = Em × |sin(θ)|   → UNIDIRECTIONAL but PULSATING\n');
disp('====================================================');

% ====================== PLOTS ======================
figure('Name','Simple Loop Generator Waveform Simulator', ...
       'Position',[100 100 1200 700]);

% ------------------- Top Plot: Alternating EMF -------------------
subplot(2,1,1);
plot(t, e_coil, 'b-', 'LineWidth', 3);
hold on;
grid on;
yline(0, '--k', 'LineWidth', 1);

title('ALTERNATING EMF in Coil (Slip Rings)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Induced EMF (V)');
xlim([0 2]);
ylim([-Em*1.2 Em*1.2]);

% Mark key positions
for i = 1:length(positions_deg)
    plot(t_pos(i), Em*sin(positions_rad(i)), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    text(t_pos(i)+0.03, Em*sin(positions_rad(i))+0.8, ...
         sprintf('%d°', positions_deg(i)), 'FontSize', 10, 'Color', 'red');
end

legend('EMF in Coil (Slip Rings)', 'Location', 'best');

% ------------------- Bottom Plot: Rectified Output -------------------
subplot(2,1,2);
plot(t, e_commutator, 'r-', 'LineWidth', 3);
hold on;
grid on;
yline(0, '--k', 'LineWidth', 1);

title('UNIDIRECTIONAL but PULSATING DC after Split-Ring Commutator', ...
      'FontSize', 14, 'FontWeight', 'bold');
xlabel('Time (seconds) → One rotation = 1 second');
ylabel('Output Voltage (V)');
xlim([0 2]);
ylim([0 Em*1.2]);

% Mark key positions
for i = 1:length(positions_deg)
    plot(t_pos(i), Em*abs(sin(positions_rad(i))), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
    text(t_pos(i)+0.03, Em*abs(sin(positions_rad(i)))+0.6, ...
         sprintf('%d°', positions_deg(i)), 'FontSize', 10, 'Color', 'red');
end

legend('Output after Commutator', 'Location', 'best');

% Overall Title
sgtitle('Simple Loop DC Generator Waveform Simulator\nAlternating EMF → Rectified by Commutator', ...
        'FontSize', 16, 'FontWeight', 'bold');

% Force figure to appear
drawnow;
figure(gcf);

disp('✅ Simulation completed! Waveform plot generated successfully.');