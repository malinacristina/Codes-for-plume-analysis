function baseline_conc = baseline(plume, valve_start, sampling, stimulus_length)

for i=1:1:size(valve_start)
    
    start_time_trial = valve_start(i,1) - 1;
    start_index = start_time_trial/sampling;
    
    background(:,i) = plume(start_index:(start_index+1/sampling),1);
    baseline_conc = mean(background);
    
end

end