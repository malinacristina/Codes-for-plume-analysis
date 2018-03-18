function [] = plot_random_trials(plume_trial, time_trial, n, plume_means, plume_SD) 
    %pick random trials
    %plume_id = randi(size(plume_trial,2), 1, n);
    plume_id = 1:n;
    
    for i=1:n
        %calculate things
        trial = plume_trial(:,plume_id(i));
        mean = plume_means(plume_id(i));
        SD = plume_SD(plume_id(i));
        mean1SD = mean + SD;
        mean2SD = mean1SD + SD;
        mean3SD = mean2SD + SD;
        
        %plot
        figure()
        plot(time_trial, trial, 'b');
        hold on
        plot([1 time_trial(length(time_trial))], [mean mean], 'r-');
        plot([1 time_trial(length(time_trial))], [mean1SD mean1SD], 'r-');
        plot([1 time_trial(length(time_trial))], [mean2SD mean2SD], 'r-');
        plot([1 time_trial(length(time_trial))], [mean3SD mean3SD], 'r-');
        ylim([-0.01 0.35]);
        xlabel('Time (s) - ODD onset = 1s');
        ylabel('PID signal (V)');
        title(plume_id(i));
        hold off
    end
end