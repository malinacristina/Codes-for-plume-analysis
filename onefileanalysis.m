clearvars;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\180205\180205_1000x80cm.mat');

plume_set(1).name = '80cm_continuous';
plume_set(1).plume = data.V180205_1000x80cm_100x40cm_Ch1.values;
plume_set(1).sampling = data.V180205_1000x80cm_100x40cm_Ch1.interval;
plume_set(1).odour = data.V180205_1000x80cm_100x40cm_Ch2.values;

plume_set(1).valve_start = data.V180205_1000x80cm_100x40cm_Ch3.times;
%plume_set(1).plume_start = data.V180205_1000x80cm_100x40cm_Ch5.times;

plume_set(1).stimuli_count = data.V180205_1000x80cm_100x40cm_Ch3.length;

plume_set(1).time = plume_set(1).sampling:plume_set(1).sampling:size(plume_set(1).plume,1)*plume_set(1).sampling;
plume_set(1).time = plume_set(1).time';

figure(1);
plot(plume_set(1).time,plume_set(1).plume)

plume_set(1).stimulus_length = 5; %for the future read this from spike file

%plume_set(1).plume_delay = delay_calc(plume_set(1).plume_start, plume_set(1).valve_start);
plume_set(1).plume_trial = get_trials(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).sampling, plume_set(1).stimulus_length);
%plume_set(1).plumes_only = get_plumes_only(plume_set(1).plume, plume_set(1).plume_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).baseline_conc = baseline(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).odour_quant = get_plume_integral(plume_set(1).plume_trial, plume_set(1).baseline_conc);
plume_set(1).PIDsignal = get_PIDsignal(plume_set(1).plume_trial, plume_set(1).baseline_conc);

plume_set(1).distance(1:plume_set(1).stimuli_count) = 80;

%% plot concentration

plot(plume_set(1).odour_quant, 'x')

coeffs = polyfit([1:999], plume_set(1).odour_quant, 3);
% Get fitted values
fittedX = linspace(1, 999, 200);
fittedY = polyval(coeffs, fittedX);
% Plot the fitted line
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 1);


