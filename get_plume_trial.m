function get_plume_trial(plume, valve_start, plume_start, sampling, stimulus_length, stimuli_count)

% gets each trial from: start = odour onset - 1 sec to end = stimulus
% length +2.5
% ex: for 5 sec stimulus it would contain 1sec before valve_start and
% 11.5sec after 

valve_end = valve_start + stimulus_length;

time = sampling:sampling:size(plume,1)*sampling;
time = time';

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

figure
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
end