%% MATLAB settings
clc; clear; format compact;

%% Graphics settings
% Use LaTeX for axis labels, text, and legend
set(groot, ...
    'defaultAxesTickLabelInterpreter','latex', ...
    'defaultTextInterpreter','latex', ...
    'defaultLegendInterpreter','latex');

% Global graphics defaults for consistent appearance
set(groot, ...
    'defaultLineLineWidth',1.15, ...
    'defaultAxesFontSize',12, ...
    'defaultTextFontSize',12);

% Figure size: [left, bottom, width, height] in points
set(gcf, 'Units', 'points', 'Position', [200,150,500,200]);

%% Signal parameters
% Cosine current with exponentially decaying amplitude
Im  = 1;          % peak current amplitude
f   = 50;         % frequency [Hz]
w   = 2*pi*f;     % angular frequency [rad/s]
tau = 0.05;       % time constant [s]

%% Time vector and waveform definition
% Signal computed over 1 s
t = 0:1e-4:1;     

% Damped oscillatory current waveform
i = Im*cos(w*t).*exp(-t/tau);

% Positive exponential envelope
envelope = Im*exp(-t/tau);

%% Plot
% Color definitions
blueColor = [0.0000 0.4470 0.7410];
redColor  = [0.8500 0.3250 0.0980];

% Plot with handles
hp1 = plot(t, i, 'Color', blueColor); hold on; grid on;
hp2 = plot(t, envelope, '--', t, -envelope, '--');
set(hp2, 'Color', redColor);
hold off;

%% Axes limits
xlim([0 200]*1e-3); % Only initial transient part is displayed, 0-200 ms
ylim(1.19*[-1 1]);  % Approximately 1.2

%% Axis ticks and labels
% Time axis in milliseconds for easier interpretation
xtick_values = 0:20e-3:200e-3;
xticks(xtick_values);
xticklabels(num2str(xtick_values'*1e3));
xlabel('$t\:[\mathrm{ms}]$');

% Y-axis normalized to peak current Im
yticks([-1 0 1]);
yticklabels({'$-I_\mathrm{m}$','0','$I_\mathrm{m}$'});
ylabel('$i(t)$');

%% Title and legend
title('$i(t)=I_\mathrm{m}\cos(\omega t)\,\mathrm{e}^{-t/\tau}$');

legend([hp1 hp2(1)], ...
    {'$i(t)$', '$\pm\,I_\mathrm{m}\,\mathrm{e}^{-t/\tau}$'}, ...
    'Location','northeast');

%% Export figure
% PDF (vector graphics) – suitable for LaTeX documents
exportgraphics(gcf, 'current_oscillatory_waveform.pdf');

% PNG (raster graphics) – suitable for web use
exportgraphics(gcf, 'current_oscillatory_waveform.png', 'Resolution', 300);