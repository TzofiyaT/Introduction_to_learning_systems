%1
load hospital;
high_bloodpressure= dataset(BloodPressure(:,1)>130);
hospital.Properties;
Desc=hospital.Properties.Description;
dsa = dataset(hospital.Age,hospital.Weight,hospital.Smoker,hospital.BloodPressure(:,2),'VarNames', {'Age','Weight','Smoker','BloodPressure'});
h3 = dsa(dsa.Age>28, {'Age' 'Weight' 'Smoker' 'BloodPressure'});

%2
dsa = dataset(hospital.Age,hospital.Weight,hospital.Smoker,hospital.BloodPressure(:,1),'VarNames', {'Age','Weight','Smoker','BloodPressure'});
lm=fitlm(dsa);
%Smoker is the variable that most effects a patients' blood pressure. 

%3
[X1, X2, X3] = meshgrid(0:3); %Finds all the possible 3rd degree polynomal combinations.
options = sortrows([X1(:), X2(:), X3(:)]);
A=length(options);
Mix = combnk(1:A,3);

minRMSE = realmax;
helpRMSE = []; 
LM = [];
helpMatrix = [];
%Each loop will result in a different matrix(A different combination of features).
%Each loop will save the value if its RMSE is lower than minRMSE.
for i=1:size(Mix,1)   
    current = options(Mix(i,:),:); % A set of three rows of the powers matrix.
    if(sum(all(current == 0)) == 0) % checks if we have row of zeroes.
        helpMatrix = [zeros(1,3);current]; % Adds zeros
        helpMatrix = [helpMatrix, zeros(4,1)]; 
        lm = fitlm(h3, helpMatrix);
        if lm.RMSE < minRMSE
            minRMSE = lm.RMSE; %Saves the model that results in the lowest RMSE 
            helpRMSE = helpMatrix; % The matrix and rmse in this loop.
            LM = lm; % The linear model for this loop.
        end
    end
end
disp('The polynomial combination with the lowest RMSE:');
disp(LM.Formula);
disp('Here is the matrix used:');
disp(helpRMSE);

% Tzofiya Taler 209371590
% Moriah Belzberg 341239440

clear
warning off;

%1 
load hospital;

%2,3 
dsa = dataset((dummyvar(hospital.Sex)),hospital.Age,hospital.Weight,hospital.Smoker,hospital.BloodPressure(:,1),'VarNames', {'Sex','Age','Weight','Smoker','BloodPressure'});
high_bloodpressure = categorical(dsa.BloodPressure(:,1)>120);
features=dsa(:,[1,2,3,4]);
test=features([1:100],:);
Y = mnrfit(double(features),high_bloodpressure);

%4
check_results=mnrval(double(Y), double(test));
results=(check_results>0.5);
Count_high_hospital = sum(count(cellstr(high_bloodpressure),'true'));
Count_high_results = sum(results(:,1)>0.5);
P=(Count_high_hospital/Count_high_results)*100;

%5
%male:    
male_high_bloodpressure=categorical(high_bloodpressure.Sex=='Male');
%features=dsa((dsa.Sex(:,1)=='Male'),{'Sex','Age','Weight','Smoker'})
%features_male=dsa(:,[1,2,3,4,]);
% test=features([1:100],:);
M = mnrfit(double(features),high_bloodpressure);
