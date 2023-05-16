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