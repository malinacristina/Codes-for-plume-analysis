clearvars;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\171219\171219_robots_40cm.mat');

plume = data.V171219_robots_80cm_40cm_EB_Ch1.values;
sampling = data.V171219_robots_80cm_40cm_EB_Ch1.interval;
odour = data.V171219_robots_80cm_40cm_EB_Ch2.values;

valve_start = data.V171219_robots_80cm_40cm_EB_Ch5.times;
plume_start = data.V171219_robots_80cm_40cm_EB_Ch6.times;

stimuli_count = data.V171219_robots_80cm_40cm_EB_Ch5.length;

time = sampling:sampling:size(plume,1)*sampling;
time = time';

plume_delay = plume_start - valve_start;
mean_delay = mean(plume_delay);

figure(1);
plot(time,plume)

stimulus_length = 5; %for the future read this from spike file
valve_end = valve_start + stimulus_length;
%% plot individual trials

for i=1:1:size(valve_start)
    
    start_time_trial = valve_start(i,1) - 1;
    start_index = start_time_trial/sampling;
    end_index = (start_time_trial + stimulus_length*2.5)/sampling;    
     
    plume_trial(:,i) = plume(start_index:end_index,1);
    background(:,i) = plume(start_index:(start_index+1/sampling),1);
    baseline_conc = mean(background);
    
    
end

time_trial = sampling:sampling:stimulus_length*2.5+sampling;
time_trial = time_trial';

time_trial2 = repmat(time_trial,1,size(plume_trial,2));

figure(2);
plot(time_trial2, plume_trial);

%% calculate concentrations

for i=1:1:size(valve_start)
    
    start_time_plume = plume_start(i,1);
    start_index = start_time_plume/sampling;
    end_index = (start_time_plume + stimulus_length)/sampling;    
     
    plumes_only(:,i) = plume(start_index:end_index,1);
    
      
    
    
end

concentration = mean(plumes_only) - baseline_conc;

time_stimulus = sampling:sampling:stimulus_length+sampling;
time_stimulus = time_stimulus';

time_stimulus2 = repmat(time_stimulus,1,size(plumes_only,2));

figure(3);
plot(time_stimulus2, plumes_only);

average_trial = mean(plume_trial,2);
average_plume = mean(plumes_only,2);

figure(4);
plot(time_trial2, average_trial);

figure(5);
plot(time_stimulus2, average_plume);

%% calculate integrals

plumes_only_corrected = plumes_only - baseline_conc;
integrals = trapz(plumes_only_corrected);

