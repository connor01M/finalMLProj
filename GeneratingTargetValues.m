clc
clear
close all
coTravelerString = string();


    for p = 1:25
        for z = p:25
            if(p ~=z)
                coTravelerString = coTravelerString + sprintf("'human%d-human%d',",p,z);
            end
        end
    end
    for p = 1:25
        for z = 1:p
            if(p ~=z)
                coTravelerString = coTravelerString + sprintf("'human%d-human%d',",p,z);
            end
        end
    end

fileID = fopen('TargetVals.txt','w');
fprintf(fileID,'%s\n',coTravelerString);