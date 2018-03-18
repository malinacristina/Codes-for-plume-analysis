function plumes_only = get_plumes_only(plume, valve_start, plume_start, sampling, stimulus_length)

%gets a section of the plume that lasts stimulus_length and starts when
%first signal is detected


baseline_conc = baseline(plume, valve_start, sampling, stimulus_length);

for i=1:1:size(plume_start)
    
    start_time_plume = plume_start(i,1);
    start_index = start_time_plume/sampling;
    end_index = (start_time_plume + stimulus_length)/sampling;    
     
    plumes_only(:,i) = plume(start_index:end_index,1) - baseline_conc(i);
    
end


end