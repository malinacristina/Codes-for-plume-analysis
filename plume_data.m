clearvars;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\171219\171219_robots_80cm_40cm_EB.mat');

plume = data.V171219_robots_80cm_40cm_EB_Ch1.values;
sampling = data.V171219_robots_80cm_40cm_EB_Ch1.interval;
odour = data.V171219_robots_80cm_40cm_EB_Ch2.values;

time = sampling:sampling:size(plume,1)*sampling;
time = time';

start80plume = 70.8*sampling;


figure(1);
plot(time,plume)

figure(2);
plot(time,odour)

%% Finding onset time

[pks,locs] = findpeaks(odour,time,'MinPeakDistance',8,'MinPeakProminence',4);
odour_pks = pks;
odour_locs = locs;

%% Chopping plume trials

time_trial = sampling:sampling:10+sampling;
time_trial = time_trial';
time_odour = sampling:sampling:5+sampling;
time_odour = time_odour';


for i=1:1:size(odour_locs,1)
    
    start_time = odour_locs(i,1) - 1;
    end_time = start_time + 9;
    
    plume_trial(:,i) = plume(start_time/sampling:end_time/sampling,1);
    
    [pks,locs] = findpeaks(plume_trial(:,i),time_trial,'MinPeakDistance',9);
   
    plume_pks(i,:) = pks;
    plume_locs(i,:) = locs;
    plume_delay(i,:) = plume_locs(i,:) - 1;
    
    %%start_odour = plume_locs(i,:)
    %%end_odour = start_odour + 3;
    
    %%plume_odour(:,i) = plume_trial(start_odour/sampling:end_odour/sampling);
     
end


time_trial2 = repmat(time_trial,1,size(plume_trial,2));

figure(3);
plot(time_trial2, plume_trial);

figure(4);
plot(time_trial, plume_trial(:,13));

%%figure(5);
%%plot(time_odour, plume_odour(:,13));

delay = mean(plume_delay);




% 
% start_time = 415;
% end_time = start_time + 3;
% 
% plume_trial = plume(start_time/sampling:end_time/sampling,1);
% 
