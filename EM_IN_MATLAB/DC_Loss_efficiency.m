
%  DC MACHINE LOSSES & EFFICIENCY CURVE SIMULATOR
%  MATLAB Version - Swinburne's Test

clc; clear; close all;

disp('====================================================');
disp('DC MACHINE LOSSES & EFFICIENCY CURVE SIMULATOR');
disp('MATLAB Version - Lecture Notes Based');
disp('====================================================');

% ====================== USER INPUTS ======================
Ra       = input('Enter Armature Resistance Ra (Ω)          [example : 0.5]: ');
P_const  = input('Enter Constant Losses (W)                [example : 800]: ');
V        = input('Enter Rated Voltage (V)                  [exampl :230]: ');
I_full   = input('Enter Full Load Current (A)              [example: 50]: ');

% Load from 10% to 120%
load_percent = linspace(10, 120, 200);
load_frac    = load_percent / 100;

% ====================== CALCULATIONS ======================
I_a         = I_full * load_frac;
P_variable  = I_a.^2 * Ra;
P_total_loss = P_const + P_variable;
P_input     = V * I_a;
P_output    = P_input - P_total_loss;
efficiency  = (P_output ./ P_input) * 100;

% Maximum efficiency point
[eta_max, idx] = max(efficiency);
P_out_max_eta  = P_output(idx);

% ====================== DISPLAY ======================
fprintf('\n');
disp('====================================================');
disp('LOSSES & EFFICIENCY RESULTS');
disp('====================================================');
fprintf('Constant Losses          = %.0f W\n', P_const);
fprintf('Armature Resistance      = %.3f Ω\n', Ra);
fprintf('Maximum Efficiency       = %.2f %%\n', eta_max);
fprintf('At Output Power          = %.0f W\n', P_out_max_eta);
disp('====================================================');

% ====================== PLOT ======================
figure('Position',[100 100 1200 700]);

yyaxis left
plot(P_output, efficiency, 'b-', 'LineWidth', 3);
ylabel('Efficiency (%)', 'FontSize', 14);
xlabel('Output Power (W)', 'FontSize', 14);
title('DC Machine Losses & Efficiency Curve (Swinburne''s Test)', ...
      'FontSize', 16, 'FontWeight', 'bold');
grid on;

hold on;
plot(P_out_max_eta, eta_max, 'ro', 'MarkerSize', 12, 'LineWidth', 2);
text(P_out_max_eta + 30, eta_max - 3, sprintf('η_max = %.2f%%\n@ %d W', eta_max, round(P_out_max_eta)), ...
     'FontSize', 12, 'Color', 'red', 'FontWeight', 'bold');

yyaxis right
plot(P_output, P_total_loss, 'r--', 'LineWidth', 2);
ylabel('Total Losses (W)', 'FontSize', 14);

legend('Efficiency Curve', 'Maximum Efficiency Point', 'Total Losses', 'Location', 'best');
hold off;

disp(' Plot generated successfully!');