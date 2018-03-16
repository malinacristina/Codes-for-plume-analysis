clearvars;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\180116\180116_1.mat');

plume = data.V180116_1_Ch1.values;
sampling = data.V180116_1_Ch1.interval;
odour = data.V180116_1_Ch2.values;

valve_start = data.V180116_1_Ch401.times;
plume_start = data.V180116_1_

time = sampling:sampling:size(plume,1)*sampling;
time = time';

start80plume = 65;
end80plume = 378;
start40plume = 748;
end40plume = 1071;

plume_40 = plume(start40plume/sampling:end40plume/sampling,1);
odour_40 = odour(start40plume/sampling:end40plume/sampling,1);
time_40 = sampling:sampling:size(plume_40,1)*sampling;
plume_80 = plume(start80plume/sampling:end80plume/sampling,1);
odour_80 = odour(start80plume/sampling:end80plume/sampling,1);
time_80 = sampling:sampling:size(plume_80,1)*sampling;

figure(1);
plot(time_40,plume_40)

figure(2);
plot(time_80,plume_80)

%% Finding onset time

[pks,locs] = findpeaks(odour_40,time_40,'MinPeakDistance',8,'MinPeakProminence',4);
odour_pks_40 = pks;
odour_locs_40 = locs;
odour_locs_40 = odour_locs_40';

[pks,locs] = findpeaks(odour_80,time_80,'MinPeakDistance',8,'MinPeakProminence',4);
odour_pks_80 = pks;
odour_locs_80 = locs;
odour_locs_80 = odour_locs_80';

[pks,locs] = findpeaks(plume_80,time_80,'MinPeakDistance',9,'MinPeakHeight',0.3);
plume_pks_80_ = pks;
plume_locs_80_ = locs;
plume_locs_80_ = plume_locs_80_';

delay_from_locs_80 = plume_locs_80_ - odour_locs_80;

%% Chopping plume trials

time_trial = sampling:sampling:10+sampling;
time_trial = time_trial';
time_odour = sampling:sampling:5+sampling;
time_odour = time_odour';


for i=1:1:size(odour_locs_40,1)
    
    start_time = odour_locs_40(i,1) - 1;
    start_index = start_time/sampling;
    end_index = start_index + 10/sampling;
    
    plume_trial_40(:,i) = plume_40(start_index:end_index,1);
    
    [pks,locs] = findpeaks(plume_trial_40(:,i),time_trial,'MinPeakDistance',9, 'MinPeakHeight',0.3);
   
    plume_pks_40(i,:) = pks;
    plume_locs_40(i,:) = locs;
    plume_delay_40(i,:) = plume_locs_40(i,:) - 1;
    
    %%start_odour = locs;
    %%end_odour = start_odour + 5/sampling;
    %%plume_odour_40(:,i) = plume_trial_40(start_odour:end_odour,1);
     
end

for i=1:1:size(odour_locs_80,1)
    
    start_time = odour_locs_80(i,1) - 1;
    start_index = start_time/sampling;
    end_time = start_time + 10;
    end_index = start_index + 10/sampling;
    plume_length(:,i) = end_index - start_index;
    
    plume_trial_80(:,i) = plume_80(start_index:end_index,1);
    
    [pks,locs] = findpeaks(plume_trial_80(:,i),time_trial,'MinPeakDistance',9, 'MinPeakHeight',0.3);
   
    plume_pks_80(i,:) = pks;
    plume_locs_80(i,:) = locs;
    plume_delay_80(i,:) = plume_locs_80(i,:) - 1;
    
     
end



time_trial2_40 = repmat(time_trial,1,size(plume_trial_40,2));

figure(3);
plot(time_trial2_40, plume_trial_40);

time_trial2_80 = repmat(time_trial,1,size(plume_trial_80,2));

figure(4);
plot(time_trial2_80, plume_trial_80);


%%for i=1:1:size(odour_locs_40,1)
    
%%    figure(i+5);
%%    plot(time_trial, plume_trial_40(:,i));
    
%%end

%%for i=1:1:size(odour_locs_80,1)
    
%%    figure(i+5);
%%    plot(time_trial, plume_trial_80(:,i));
    
%%end

%%figure(5);
%%plot(time_odour, plume_odour(:,13));

delay_40 = mean(plume_delay_40);
delay_80 = mean(plume_delay_80);

concentration_40 = mean(plume_trial_40);
concentration_80 = mean(plume_trial_80);

% 
% start_time = 415;
% end_time = start_time + 3;
% 
% plume_trial = plume(start_time/sampling:end_time/sampling,1);
% 
