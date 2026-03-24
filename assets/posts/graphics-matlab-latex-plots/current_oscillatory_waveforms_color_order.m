%% Settings
clc; clear; format compact;

% LaTeX as default interpreter
set(groot, ...
    'defaultAxesTickLabelInterpreter','latex', ...
    'defaultTextInterpreter','latex', ...
    'defaultLegendInterpreter','latex');

% Figure settings and size: [left, bottom, width, height] in points
hold on; grid on;
set(gcf, 'Units', 'points', 'Position', [200,150,500,200]);

%% Time vector
t = 0:1e-4:0.2;

%% Signal parameters
% Main parameters
Im = 1; f  = 50; w  = 2*pi*f;

% Set of damping factors
tau_values = [0.02 0.04 0.06 0.08 0.10 0.12 0.14];

%% Plot signals (each gets next color automatically)
for k = 1:length(tau_values)
    tau = tau_values(k);
    i = Im*cos(w*t).*exp(-t/tau);

    plot(t*1e3, i, 'LineWidth', 1.2);
end
hold off;

%% Labels
xlabel('$t\:[\mathrm{ms}]$');
ylabel('$i(t)$');

xlim([0 50]);

title('Damped oscillatory signals for different $\tau$');

%% Legend
lgd = legend(arrayfun(@(x) sprintf('$\\tau = %.2f\\,\\mathrm{s}$', x), ...
    tau_values, 'UniformOutput', false), ...
    'Location','eastoutside','Orientation','vertical','NumColumns',1);
lgd.Title.String = '$\mathrm{Time\:constant\:}\tau$';

%% Export figure
% PDF (vector graphics) – suitable for LaTeX documents
exportgraphics(gcf, 'current_oscillatory_waveforms_color_order.pdf');

% PNG (raster graphics) – suitable for web use
exportgraphics(gcf, 'current_oscillatory_waveforms_color_order.png', 'Resolution', 300);
