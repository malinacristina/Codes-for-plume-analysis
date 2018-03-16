%% 1000ppm

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\PID calibration\180311_1000ppm.mat');

sampling = data.V180311_PIDcal_Ch1.interval;
intervals = data.V180311_PIDcal_Ch3.times;
trace = data.V180311_PIDcal_Ch1.values;

for i = 1:2:length(intervals)
    startindex = (intervals(i)+1)/sampling;
    endindex = (startindex*sampling + 20)/sampling - 1;
    column = round(i/2);
    signal(:,column) = trace(startindex:endindex,1);
    end

cal_points_1000ppm = mean(signal);

%% 100ppm

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\PID calibration\180311_100ppm.mat');

intervals = data.V180311_PIDcal_Ch3.times;
trace = data.V180311_PIDcal_Ch1.values;

for i = 1:2:length(intervals)
    startindex = (intervals(i)+1)/sampling;
    endindex = (startindex*sampling + 20)/sampling - 1;
    column = round(i/2);
    signal(:,column) = trace(startindex:endindex,1);
end

cal_points_100ppm = mean(signal);

%% 10ppm

data = load('C:\Users\marinc\OneDrive - The Francis Crick Institute\Data\Tunnel Calibration\Raw data\PID calibration\180311_10ppm.mat');

intervals = data.V180311_PIDcal_Ch3.times;
trace = data.V180311_PIDcal_Ch1.values;

for i = 1:2:length(intervals)
    startindex = (intervals(i)+1)/sampling;
    endindex = (startindex*sampling + 20)/sampling - 1;
    column = round(i/2);
    signal(:,column) = trace(startindex:endindex,1);
end

cal_points_10ppm = mean(signal);

%% make calibration curve

concentrations = [1000, 1000, 1000, 100, 100, 100, 10, 10, 10];
PIDreads = [cal_points_1000ppm, cal_points_100ppm, cal_points_10ppm];

figure(1)
hold on
plot(concentrations, PIDreads, 'o')
p = polyfit(concentrations,PIDreads,1); 
f = polyval(p,concentrations); 
plot(concentrations,PIDreads,'o',concentrations,f,'-')
legend('data','linear fit') 

%% get equation to get other points



   