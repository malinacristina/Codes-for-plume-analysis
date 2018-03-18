clear all;

% This script segments plumes from the mat file exported from spike and
% calls functions to calculate various descriptive statistics and add them
% to the plume_set that will be stored for further analysis;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\180314\180314_tightlidrobot_40cm.mat');

stimulus_length = 5;  %for the future read this from spike file

plume_set(1).name = '40cm';
plume_set(1).plume = data.V180314_tightlidrobot_Ch1.values;
plume_set(1).sampling = data.V180314_tightlidrobot_Ch1.interval;
plume_set(1).odour = data.V180314_tightlidrobot_Ch2.values;
plume_set(1).valve_start = data.V180314_tightlidrobot_Ch3.times;
plume_set(1).plume_start = data.V180314_tightlidrobot_Ch4.times;
plume_set(1).stimuli_count = data.V180314_tightlidrobot_Ch4.length;
plume_set(1).time = plume_set(1).sampling:plume_set(1).sampling:size(plume_set(1).plume,1)*plume_set(1).sampling;
plume_set(1).time = plume_set(1).time';

plume_set(1).stimulus_length = stimulus_length;

plume_set(1).plume_delay = delay_calc(plume_set(1).plume_start, plume_set(1).valve_start);
plume_set(1).baseline_conc = baseline(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).plume_trial = get_trials(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).plumes_only = get_plumes_only(plume_set(1).plume, plume_set(1).valve_start, plume_set(1).plume_start, plume_set(1).sampling, plume_set(1).stimulus_length);
plume_set(1).plume_integral = get_plume_integral(plume_set(1).plumes_only, plume_set(1).baseline_conc);
plume_set(1).PIDsignal = get_PIDsignal(plume_set(1).plumes_only, plume_set(1).baseline_conc);

plume_set(1).distance(1:plume_set(1).stimuli_count) = 40;

%% get second set of trials

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\180314\180314_tightlidrobot_80cm.mat');

plume_set(2).name = '80cm';
plume_set(2).plume = data.V180314_tightlidrobot_Ch1.values;
plume_set(2).sampling = data.V180314_tightlidrobot_Ch1.interval;
plume_set(2).odour = data.V180314_tightlidrobot_Ch2.values;

plume_set(2).valve_start = data.V180314_tightlidrobot_Ch3.times;
plume_set(2).plume_start = data.V180314_tightlidrobot_Ch4.times;

plume_set(2).stimuli_count = data.V180314_tightlidrobot_Ch3.length;

plume_set(2).time = plume_set(2).sampling:plume_set(2).sampling:size(plume_set(2).plume,1)*plume_set(2).sampling;
plume_set(2).time = plume_set(2).time';

plume_set(2).stimulus_length = stimulus_length;

plume_set(2).plume_delay = delay_calc(plume_set(2).plume_start, plume_set(2).valve_start);
plume_set(2).baseline_conc = baseline(plume_set(2).plume, plume_set(2).valve_start, plume_set(2).sampling, plume_set(2).stimulus_length);
plume_set(2).plume_trial = get_trials(plume_set(2).plume, plume_set(2).valve_start, plume_set(2).sampling, plume_set(2).stimulus_length);
plume_set(2).plumes_only = get_plumes_only(plume_set(2).plume, plume_set(2).valve_start, plume_set(2).plume_start, plume_set(2).sampling, plume_set(2).stimulus_length);
plume_set(2).plume_integral = get_plume_integral(plume_set(2).plumes_only, plume_set(2).baseline_conc);
plume_set(2).PIDsignal = get_PIDsignal(plume_set(2).plumes_only, plume_set(2).baseline_conc);
plume_set(2).distance(1:plume_set(2).stimuli_count) = 80;

sampling = plume_set(1).sampling;
time_trial = sampling:sampling:stimulus_length*2.5+sampling;
time_trial = time_trial';
time_trials = sampling:sampling:stimulus_length+1*sampling;

%% Signal (integrals) for each trial

[h,p,ci] = ttest2(plume_set(1).plume_integral,plume_set(2).plume_integral);

figure
h1 = scatter(plume_set(1).distance,plume_set(1).plume_integral,'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).plume_integral,'x');
title(p)
xlabel('Distance to source')
ylabel('Integral')
xlim([30 90])


%% SD for each trial

plume_set(1).stds = std(plume_set(1).plumes_only);
plume_set(2).stds = std(plume_set(2).plumes_only);

%% Fraction of trial above mean + 1SD

plume_set(1).above1sd = fraction_aboveSD(plume_set(1).plumes_only,1);
plume_set(2).above1sd = fraction_aboveSD(plume_set(2).plumes_only,1);

%% Fraction of trial above mean + 2SD

plume_set(1).above2sd = fraction_aboveSD(plume_set(1).plumes_only,2);
plume_set(2).above2sd = fraction_aboveSD(plume_set(2).plumes_only,2);

%% Fraction of trial above mean + 3SD

plume_set(1).above3sd = fraction_aboveSD(plume_set(1).plumes_only,3);
plume_set(2).above3sd = fraction_aboveSD(plume_set(2).plumes_only,3);
%% Save workspace
