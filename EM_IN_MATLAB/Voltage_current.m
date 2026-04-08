%  DC GENERATOR CLASSIFICATION & VOLTAGE/CURRENT RELATIONS SIMULATOR

clc; clear; close all;

disp('====================================================');
disp('DC GENERATOR CLASSIFICATION & VOLTAGE/CURRENT RELATIONS');
disp('====================================================');

% ====================== USER INPUTS ======================
E = input('Enter Generated EMF E (V)          [example: 230]: ');
Ra  = input('Enter Armature resistance Ra (Ω)   [example: 0.5]: ');
Rsh  = input('Enter Shunt field resistance Rsh (Ω) [example: 200]: ');
Rsc = input('Enter Series field resistance Rsc (Ω) [example: 0.3]: ');
Vbrush = input('Enter Brush drop Vbrush (V)       [example: 2]: ');
IL_max = input('Enter Maximum Load Current IL (A) [example: 50]: ');

IL = linspace(0, IL_max, 300);   % Load current array

%  CALCULATIONS 

% 1. Separately Excited Generator
Ia_se = IL + (E / Rsh);                    % Field current from separate supply
Vt_se = E - Ia_se * Ra - Vbrush;

% 2. Shunt Generator (Self-excited)
Vt_sh = zeros(size(IL));
for i = 1:length(IL)
    % Approximate solution
    Vt_sh(i) = E - IL(i)*Ra - Vbrush - (IL(i)*Ra*Ra/Rsh);
end

% 3. Series Generator
Ia_series = IL;
Vt_series = E - Ia_series.*(Ra + Rsc) - Vbrush;

% 4. Long Shunt Compound Generator
Vt_long = zeros(size(IL));
for i = 1:length(IL)
    Vt_long(i) = E - IL(i)*(Ra + Rsc) - Vbrush - (IL(i)*Ra/Rsh);
end

% 5. Short Shunt Compound Generator
Vt_short = E - IL.*(Ra + Rsc) - Vbrush - (IL.*Ra/Rsh);

% ====================== DISPLAY EQUATIONS ======================
fprintf('\n');
disp('====================================================');
disp('VOLTAGE & CURRENT RELATIONS');
disp('====================================================');
disp('1. Separately Excited :   E = Vt + Ia Ra + Vbrush');
disp('2. Shunt Generator     :   E = Vt + Ia Ra + Vbrush    (Ia = IL + Ish)');
disp('3. Series Generator    :   E = Vt + Ia(Ra + Rsc) + Vbrush');
disp('4. Long Shunt Compound :   E = Vt + Ia(Ra + Rsc) + Vbrush');
disp('5. Short Shunt Compound:   E = Vt + Ia(Ra + Rsc) + Vbrush');
disp('====================================================');
fprintf('Generated EMF E       = %.2f V\n', E);
fprintf('Brush drop            = %.2f V\n', Vbrush);
disp('====================================================');

% ====================== PLOT LOAD CHARACTERISTICS ======================
figure('Position', [100 100 1200 700]);

plot(IL, Vt_se,      'b-', 'LineWidth', 2.5, 'DisplayName', 'Separately Excited');
hold on;
plot(IL, Vt_sh,      'g-', 'LineWidth', 2.5, 'DisplayName', 'Shunt Generator');
plot(IL, Vt_series,  'r-', 'LineWidth', 2.5, 'DisplayName', 'Series Generator');
plot(IL, Vt_long,    'm-', 'LineWidth', 2.5, 'DisplayName', 'Long Shunt Compound');
plot(IL, Vt_short,   'c-', 'LineWidth', 2.5, 'DisplayName', 'Short Shunt Compound');

yline(E, '--k', 'Generated EMF E', 'LineWidth', 1.5, 'LabelHorizontalAlignment','left');

title('DC Generator External Characteristics (Vt vs IL)', ...
      'FontSize', 16, 'FontWeight', 'bold');
xlabel('Load Current I_L (A)', 'FontSize', 14);
ylabel('Terminal Voltage V_t (V)', 'FontSize', 14);
grid on;
legend('Location', 'best', 'FontSize', 12);
ylim([0 E*1.1]);
xlim([0 IL_max]);

text(IL_max*0.6, E*0.85, 'Voltage drops due to I_aR_a + Brush drop', ...
     'FontSize', 11, 'Color', 'darkred', 'FontWeight', 'bold');

hold off;

disp('Plot generated successfully!');