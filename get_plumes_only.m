function plumes_only = get_plumes_only(plume, valve_start, plume_start, sampling, stimulus_length)

%gets a section of the plume that ignores the first second from plume_start
%and lasts stimulus_length-1
%ex: last 4 sec of a 5 sec stimulus starting from first detection from PID

baseline_conc = baseline(plume, valve_start, sampling, stimulus_length);

for i=1:1:size(plume_start)
    
    start_time_plume = plume_start(i,1) + 1;
    start_index = start_time_plume/sampling;
    end_index = (start_time_plume + stimulus_length - 1)/sampling;    
     
    plumes_only(:,i) = plume(start_index:end_index,1) - baseline_conc(i);
    
end


end