%% Counting peaks above 2*stdev

plume_set(1).Splumes_only=std(plume_set(1).plumes_only);
plume_set(2).Splumes_only=std(plume_set(2).plumes_only);

for i=1:1:plume_set(1).stimuli_count
    pks=findpeaks(plume_set(1).plumes_only(:,i),'MinPeakProminence',plume_set(1).Splumes_only(i));
    findpeaks(plume_set(1).plumes_only(:,i), 'MinPeakProminence',plume_set(1).Splumes_only(i))
    % ,'MinPeakHeight',2*plume_set(1).Splumes_only(i));
    
end

%% Counting peaks above 2*stdev in all plume rather than per trial
stdev1 = std(plume_set(1).plume)
stdev2 = std(plume_set(2).plume)
figure(1)
findpeaks(plume_set(1).plume, 'MinPeakProminence',2*stdev1)
figure(2)
findpeaks(plume_set(2).plume, 'MinPeakProminence',2*stdev2)

count1=numel(findpeaks(plume_set(1).plume,'MinPeakProminence',2*stdev1));
count2=numel(findpeaks(plume_set(2).plume,'MinPeakProminence',2*stdev2));