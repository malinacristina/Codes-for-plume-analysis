function plume_trial = get_trials(plume, valve_start, sampling, stimulus_length)

% this function gets a trial from start-1 to stimulus_length*2.5sec

baseline_conc = baseline(plume, valve_start, sampling, stimulus_length);

for i=1:1:size(valve_start)
    
    start_time_trial = valve_start(i,1) - 1;
    start_index = start_time_trial/sampling;
    end_index = (start_time_trial + stimulus_length*2.5)/sampling;    
    
    plume_trial(:,i) = plume(start_index:end_index,1) - baseline_conc(i);
    
        
end


end