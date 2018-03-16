%% All plumes
sampling = plume_set(1).sampling;

figure(1)
subplot(2,1,1)
plot(plume_set(1).plume, 'b')
ylim([0.15 0.4])
title('40cm')
subplot(2,1,2)
plot(plume_set(2).plume, 'r')
ylim([0.15 0.4])
title('80cm')


%% All plumes superimposed

sampling = plume_set(1).sampling;
stimulus_length = plume_set(1).stimulus_length;

time_trial = (sampling:sampling:stimulus_length*2.5+sampling)';
time_trial2 = repmat(time_trial,1,size(plume_set(1).plume_trial,2));

figure(2)
plot(time_trial2, plume_set(1).plume_trial, 'b')
hold on
plot(time_trial2, plume_set(2).plume_trial, 'r')
xlabel('Time (s) - ODD onset = 1s')
ylabel('PID signal (V)');
title('All plumes');
hold off

%% All plumes only superimposed

sampling = plume_set(1).sampling;
stimulus_length = plume_set(1).stimulus_length - 1;

time_trials = (sampling:sampling:stimulus_length+1*sampling)';
time_trials2 = repmat(time_trials,1,size(plume_set(1).plumes_only,2));

figure(3)
plot(time_trials2, plume_set(1).plumes_only, 'b')
hold on
plot(time_trials2, plume_set(2).plumes_only, 'r')
xlabel('Time (s)')
ylabel('PID signal (V)');
title('All plumes only');
hold off

%% Average plumes

figure(4)
plot(time_trial, mean(plume_set(1).plume_trial,2), 'b')
hold on
plot(time_trial, mean(plume_set(2).plume_trial,2), 'r')
xlabel('Time (s) - ODD onset = 1s')
ylabel('PID signal (V)');
title('Average trials');
ylim([-0.01 0.09])
legend('40cm', '80cm', 'Location', 'southoutside');
hold off

%% Average plumes only

figure(5)
plot(time_trials, mean(plume_set(1).plumes_only,2), 'b')
hold on
plot(time_trials, mean(plume_set(2).plumes_only,2), 'r')
xlabel('Time (s) - ODD onset = 1s')
ylabel('PID signal (V)');
title('Average plumes only');
legend('40cm', '80cm', 'Location', 'southoutside');
hold off

%% Concentration Scatter Plot
% done by mean PID signal over the plume only trace (the time interval
% equal to stimulus length from the first odour detection read from odour
% start)

[h,p,ci] = ttest2(plume_set(1).PIDsignal,plume_set(2).PIDsignal);

figure(6)
h1 = scatter(plume_set(1).distance,plume_set(1).PIDsignal,'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).PIDsignal,'x');
title(p)
legend('40cm', '80cm')
xlabel('Distance to source (cm)')
ylabel('PID signal(V) - mean over last 4sec of stimulus')
ylim([0 0.05])
xlim([30 90])
hold off

%% SD for each trial - plumes only

[h,p,ci] = ttest2(plume_set(1).stds,plume_set(2).stds);
figure(7)
h1 = scatter(plume_set(1).distance,plume_set(1).stds,'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).stds,'x');
title(p)
xlabel('Distance to source (cm)')
ylabel('SD')
xlim([30 90])
ylim([0 0.05])
hold off

%% SD Boxplot

[h,p,ci] = ttest2(plume_set(1).stds,plume_set(2).stds);

figure(8)
subplot(1,2,1);
boxplot(plume_set(1).stds,plume_set(1).distance);
hold on
title('p = ')
ylabel('SD')
ylim([0 0.05])
subplot(1,2,2);
boxplot(plume_set(2).stds,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 0.05])
%xlim([30 90])
hold off

% %% Variance of each trial
% plume_set(1).var_trial=std(plume_set(1).plume_trial);
% plume_set(2).var_trial=std(plume_set(2).plume_trial);
% 
% [h,p,ci] = ttest2(plume_set(1).var_trial,plume_set(2).var_trial);
% 
% figure(8)
% h1 = scatter(plume_set(1).distance,plume_set(1).var_trial,'o');
% hold on
% h2 = scatter(plume_set(2).distance,plume_set(2).var_trial,'x');
% title(p)
% xlabel('Distance to source (cm)')
% ylabel('Variance - trial')
% xlim([30 90])
%  hold off
%  
% %% Variance of plumes only
% plume_set(1).var_plume=std(plume_set(1).plumes_only);
% plume_set(2).var_plume=std(plume_set(2).plumes_only);
% 
% [h,p,ci] = ttest2(plume_set(1).var_plume,plume_set(2).var_plume);
% 
% figure(9)
% h1 = scatter(plume_set(1).distance,plume_set(1).var_plume,'o');
% hold on
% h2 = scatter(plume_set(2).distance,plume_set(2).var_plume,'x');
% title(p)
% xlabel('Distance to source (cm)')
% ylabel('Variance - plumes only')
% xlim([30 90])
% hold off

%% Fraction above mean + 1SD (SD calculated for each trial individually)

figure(10)
h1 = scatter(plume_set(1).distance, plume_set(1).above1sd, 'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).above1sd,'x');
title('Fraction above mean+1SD')
xlabel('Distance to source (cm)')
ylabel('Fraction above mean+1SD (odour)')
xlim([30 90])
hold off

%%  Fraction above mean + 1SD (SD calculated for each trial individually)

[h,p,ci] = ttest2(plume_set(1).above1sd,plume_set(2).above1sd);

figure(11)
subplot(1,2,1);
boxplot(plume_set(1).above1sd,plume_set(1).distance);
hold on
title('Fraction above mean+1SD')
ylabel('Fraction above mean+1SD (odour)')
ylim([0 0.2])
subplot(1,2,2);
boxplot(plume_set(2).above1sd,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 0.2])
%xlim([30 90])
hold off

%% Fraction above mean + 2SD (SD calculated for each trial individually)

figure(12)
h1 = scatter(plume_set(1).distance, plume_set(1).above2sd, 'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).above2sd,'x');
title('Fraction above mean+2SD')
xlabel('Distance to source (cm)')
ylabel('Fraction above mean+2SD (odour)')
xlim([30 90])
hold off

%%  Fraction above mean + 2SD (SD calculated for each trial individually)

[h,p,ci] = ttest2(plume_set(1).above2sd,plume_set(2).above2sd);

figure(13)
subplot(1,2,1);
boxplot(plume_set(1).above2sd,plume_set(1).distance);
hold on
title('Fraction above mean+2SD')
ylabel('Fraction above mean+2SD (odour)')
ylim([0 0.2])
subplot(1,2,2);
boxplot(plume_set(2).above2sd,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 0.2])
%xlim([30 90])
hold off

%%  Fraction above mean + 3SD (SD calculated for each trial individually)

[h,p,ci] = ttest2(plume_set(1).above3sd,plume_set(2).above3sd);

figure(14)
subplot(1,2,1);
boxplot(plume_set(1).above3sd,plume_set(1).distance);
hold on
title('Fraction above mean+3SD')
ylabel('Fraction above mean+3SD (odour)')
ylim([0 0.2])
subplot(1,2,2);
boxplot(plume_set(2).above3sd,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 0.2])
%xlim([30 90])
hold off

%% Fraction above mean + 3SD (SD calculated for each trial individually)
figure(15)
h1 = scatter(plume_set(1).distance, plume_set(1).above3sd, 'o');
hold on
h2 = scatter(plume_set(2).distance,plume_set(2).above3sd,'x');
title('Fraction above mean+3SD')
xlabel('Distance to source (cm)')
ylabel('Fraction above mean+3SD (odour)')
xlim([30 90])
hold off

%% Mean signal boxplot
% done by mean PID signal over the plume only trace (the time interval
% equal to stimulus length from the first odour detection read from odour
% start)

[h,p,ci] = ttest2(plume_set(1).PIDsignal,plume_set(2).PIDsignal);

figure(16)
subplot(1,2,1);
boxplot(plume_set(1).PIDsignal,plume_set(1).distance);
hold on
title('p = ')
ylabel('PID signal(V) - mean over last 4sec of stimulus')
ylim([0 0.05])
subplot(1,2,2);
boxplot(plume_set(2).PIDsignal,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 0.05])
%xlim([30 90])
hold off
%% Delay boxplot

[h,p,ci] = ttest2(plume_set(1).plume_delay,plume_set(2).plume_delay);

figure(17)
subplot(1,2,1);
boxplot(plume_set(1).plume_delay,plume_set(1).distance);
hold on
title('p = ')
ylabel('Time from robot told to open (s)')
ylim([0 5])
subplot(1,2,2);
boxplot(plume_set(2).plume_delay,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 5])
%xlim([30 90])
hold off
