kurtosis40 = kurtosis(plume_set(1).plumes_only);
kurtosis80 = kurtosis(plume_set(2).plumes_only);

[h,p,ci] = ttest2(kurtosis40,kurtosis80);

figure(1)
subplot(1,2,1);
boxplot(kurtosis40,plume_set(1).distance);
hold on
title('p = ')
ylabel('Kurtosis')
ylim([0 40])
subplot(1,2,2);
boxplot(kurtosis80,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 40])
%xlim([30 90])
hold off
