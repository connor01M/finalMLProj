clc
clear
close all
coTravelerString = string();
l = false;
listofrandomLocations = strings(10000);
closestDist = 9999;
for i = 1:10000 %number of timesteps
    %In general, you can generate N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1).
    %Auto generates all the numbers for the dataset
    randomLocationsLong = 1+randperm(2000,25);
    randomLocationsLAT = 1+randperm(2000,25);
    %originally wanted algorithm to identify closest pair of devices but
    %that didnt work well at all
    %It is now used as like a boolean to tell if CoTraveler is detected or
    %not
    closestDist = 9999;
    l = false;
    firstNum = 0;
    secondNum = 0;
    
    %For loop cycles through every device for distance comparison
    for p = 1:length(randomLocationsLong)
        for z = p:length(randomLocationsLong)
            loc1 = [randomLocationsLAT(p);randomLocationsLong(p)];
            loc2 = [randomLocationsLAT(z);randomLocationsLong(z)];
            %Compares distances of every device to see if co traveler is present.
            if(norm(loc1 - loc2)<50 && p~=z)
                if (closestDist == 9999)
                    closestDist = norm(loc1 - loc2);
                    firstNum = p;
                    secondNum = z;
                elseif(norm(loc1 - loc2)<= closestDist && p~=z)
                    closestDist = norm(loc1 - loc2);
                    firstNum = p;
                    secondNum = z;
                end 
            end
        end
    end
    if (closestDist ~= 9999 ) 
        %sets cotraveler string to closest devices
        coTravelerString = sprintf(',%d%d',[firstNum;secondNum]);
    end
    disp(randomLocationsLong);
    temp = sprintf('%d,%d,',[randomLocationsLAT;randomLocationsLong]);
    temp(end) = [];
    listofrandomLocations(i) = temp;
    if (closestDist == 9999)
        %sets cotraveler string to 0 as no Cotravelers are present
        coTravelerString = ",0";
    end
    listofrandomLocations(i) = listofrandomLocations(i) + coTravelerString;
    coTravelerString = "";
end

numhumans = zeros(0,50);
tx = 1;
%Used to auto generate the features
for i = 1:25
        numhumans(tx) = i;
        tx = tx + 1;
        numhumans(tx) = i;
        tx = tx + 1;
end
temp2 = sprintf('%d,',numhumans);
temp2(end) = [];

fileID = fopen('MLdata.txt','w');
fprintf(fileID,'%s\n',listofrandomLocations);

