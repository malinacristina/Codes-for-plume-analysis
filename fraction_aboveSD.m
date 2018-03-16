function fraction_aboveSD = fraction_aboveSD(plumes, threshold)

% where plumes is the matrix with the individual trials to be analysed and
% threshold how many SDs it should compare it to

fraction_aboveSD(1:size(plumes,2)) = 0;
points_aboveSD(1:size(plumes,2)) = 0;
SD = std(plumes);
means = mean(plumes,1);

for i=1:size(plumes,2) % for every trial
    for j=1:size(plumes,1) % for every reading in a trial
        if plumes(j,i) > (threshold*SD + means(i))
            points_aboveSD(i) = points_aboveSD(i) + 1;
        end       
    end  
    
    fraction_aboveSD(i) = points_aboveSD(i);
        
end

end
