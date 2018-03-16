clearvars;

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\171208\171208_robot_80cm_40cm.mat');

whole_plume = data.V171208_robot_80cm_40cm_Ch1.values;
sampling = data.V171208_robot_80cm_40cm_Ch1.interval;

whole_time = sampling:sampling:size(whole_plume,1)*sampling;
whole_time = whole_time';

% figure(1);
% plot(whole_time,whole_plume)

%% Getting only the part we need

start_t = 1180.2;
end_t = 1310;

plume = whole_plume(start_t/sampling:end_t/sampling,1);
time = sampling:sampling:size(plume,1)*sampling;
time = time';


figure(2);
plot(time,plume);



%% Finding onset time

[pks,locs] = findpeaks(plume,time,'MinPeakDistance',8,'MinPeakHeight',0.350);


%% Chopping plume trials
start_trial = 1;
end_trial = start_trial + 10;



for i=1:1:size(locs,1)
    
    start_odour = start_trial + 1;
    end_odour = start_odour + 5;

    bg(:,i)= plume(start_trial/sampling:start_odour/sampling,1);
   
    plume_trial(:,i) = plume(start_trial/sampling:end_trial/sampling,1);
    odour_trial(:,i) = plume(start_odour/sampling:end_odour/sampling,1);
    
    start_trial = start_trial + 10;
    end_trial = end_trial + 10;
 
    
end

background = mean(bg);
concentration = mean(odour_trial);
concentration_corrected = concentration - background;


time_trial = sampling:sampling:size(plume_trial,1)*sampling;
time_trial = time_trial';
time_trial2 = repmat(time_trial,1,size(plume_trial,2));

time_odour = sampling:sampling:size(odour_trial,1)*sampling;
time_odour = time_odour';
time_odour2 = repmat(time_odour,1,size(odour_trial,2));

figure(3);
plot(time_trial2, plume_trial);

figure(4);
plot(time_trial, plume_trial(:,11));

