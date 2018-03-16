skewness40 = skewness(plume_set(1).plumes_only);
skewness80 = skewness(plume_set(2).plumes_only);

[h,p,ci] = ttest2(skewness40,skewness80);

figure(1)
subplot(1,2,1);
boxplot(skewness40,plume_set(1).distance);
hold on
title('p = ')
ylabel('Skewness')
ylim([0 5])
subplot(1,2,2);
boxplot(skewness80,plume_set(2).distance);
title(p);
%legend('40cm', '80cm')
ylim([0 5])
%xlim([30 90])
hold off
