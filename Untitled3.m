clearvars;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\180131\180131_40cm_side.mat');


plume_set(1).name = '40cm';
plume_set(1).plume = data.V180131_80cm_40cm_dishtoside_Ch1.values;
plume_set(1).sampling = data.V180131_80cm_40cm_dishtoside_Ch1.interval;
plume_set(1).odour = data.V180131_80cm_40cm_dishtoside_Ch2.values;

plume_set(1).valve_start = data.V180131_80cm_40cm_dishtoside_Ch3.times;
plume_set(1).plume_start = data.V180131_80cm_40cm_dishtoside_Ch5.times;

plume_set(1).stimuli_count = data.V180131_80cm_40cm_dishtoside_Ch5.length;

plume_set(1).time = plume_set(1).sampling:plume_set(1).sampling:size(plume_set(1).plume,1)*plume_set(1).sampling;
plume_set(1).time = plume_set(1).time';

figure(1);
plot(plume_set(1).time,plume_set(1).plume)

plume_set(1).stimulus_length = 5; %for the future read this from spike file

plume_set(1).plume_delay = delay_calc(plume_set(1).plume_start, plume_set(1).valve_start);
plume_set(1).plume_trial = get_trials(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).plumes_only = get_plumes_only(plume_set(1).plume, plume_set(1).plume_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).baseline_conc = baseline(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).odour_quant = get_plume_integral(plume_set(1).plumes_only, plume_set(1).baseline_conc);
plume_set(1).PIDsignal = get_PIDsignal(plume_set(1).plumes_only, plume_set(1).baseline_conc);

plume_set(1).distance(1:plume_set(1).stimuli_count) = 40;

%% get second set of trials

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\180131\180131_80cm.mat');

plume_set(2).name = '80cm';
plume_set(2).plume = data.V180131_80cm_40cm_dishtoside_Ch1.values;
plume_set(2).sampling = data.V180131_80cm_40cm_dishtoside_Ch1.interval;
plume_set(2).odour = data.V180131_80cm_40cm_dishtoside_Ch2.values;

plume_set(2).valve_start = data.V180131_80cm_40cm_dishtoside_Ch3.times;
plume_set(2).plume_start = data.V180131_80cm_40cm_dishtoside_Ch4.times;

plume_set(2).stimuli_count = data.V180131_80cm_40cm_dishtoside_Ch3.length;

plume_set(2).time = plume_set(2).sampling:plume_set(2).sampling:size(plume_set(2).plume,1)*plume_set(2).sampling;
plume_set(2).time = plume_set(2).time';

figure(2);
plot(plume_set(2).time,plume_set(2).plume)

plume_set(2).stimulus_length = 5; %for the future read this from spike file

plume_set(2).plume_delay = delay_calc(plume_set(2).plume_start, plume_set(2).valve_start);
plume_set(2).plume_trial = get_trials(plume_set(2).plume, plume_set(2).valve_start, plume_set(2).sampling, plume_set(2).stimulus_length);
plume_set(2).plumes_only = get_plumes_only(plume_set(2).plume, plume_set(2).plume_start, plume_set(2).sampling, plume_set(2).stimulus_length);
plume_set(2).baseline_conc = baseline(plume_set(2).plume, plume_set(2).valve_start, plume_set(2).sampling, plume_set(2).stimulus_length);
plume_set(2).odour_quant = get_plume_integral(plume_set(2).plumes_only, plume_set(2).baseline_conc);
plume_set(2).PIDsignal = get_PIDsignal(plume_set(2).plumes_only, plume_set(2).baseline_conc);
plume_set(2).distance(1:plume_set(2).stimuli_count) = 80;

[h,p,ci] = ttest2(plume_set(1).odour_quant,plume_set(2).odour_quant);

figure
h1 = scatter(plume_set(1).distance,plume_set(1).odour_quant,'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).odour_quant,'x');
title(p)
xlabel('Distance to source')
ylabel('Integral')
xlim([30 90])






