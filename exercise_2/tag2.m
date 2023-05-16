

clear
warning off;

%1 
load hospital;

%2,3 
dsa = dataset((dummyvar(hospital.Sex)),hospital.Age,hospital.Weight,hospital.Smoker,hospital.BloodPressure(:,1),'VarNames', {'Sex','Age','Weight','Smoker','BloodPressure'});%turns Sex feature into a Dummy Var (two separate column of 1 and 0)
high_bloodpressure = categorical(dsa.BloodPressure(:,1)>120); %Category of high blood pressure is above 120 will be represented as a 1 low blood pressure 0
features=dsa(:,[1,2,3,4]); %Our features are the first 4 column of our data set(not including blood pressure) 
Y = mnrfit(double(features),high_bloodpressure); %Logistic regression using our features to predict high blood pressure

%4
test=features([1:100],:); %take the first 100 rows to test their results
check_results=mnrval(double(Y), double(test)); % function that shows us the chance that based on our test features the sample is in the first group or second group high/low blood pressure
results=(check_results>0.5);%change all values above 50% to be 1 and below 0- So it matches our high_bloodpressure matrix
Count_high_hospital = sum(count(cellstr(high_bloodpressure),'true'));
Count_high_results = sum(results(:,1)>0.5); % compares results of test to the actual results
P=(Count_high_hospital/Count_high_results)*100; %turns into a percent value
disp(['The model accuracy for all patients is: ', num2str(P), '%']);

%5
dsa = sortrows(dsa,'Sex','ascend');
%male:
male_patients=dsa(47:100,[2,3,4,5]);
male_high_bloodpressure = categorical(male_patients.BloodPressure(:,1)>120);
features_male=dsa(47:100,[2,3,4]); % Sex feature is no longer significant 
Y1 = mnrfit(double(features_male),male_high_bloodpressure); %Logistic regression using our features to predict high blood pressure

test1=features_male(:,:); %take all rows to test their results
check_results=mnrval(double(Y1), double(test1)); % function that shows us the chance that based on our test features the sample is in the first group or second group high/low blood pressure
results=(check_results>0.5);%change all values above 50% to be 1 and below 0- So it matches our high_bloodpressure matrix
Count_high_hospital = sum(count(cellstr(male_high_bloodpressure),'true'));
Count_high_results = sum(results(:,1)>0.5); % compares results of test to the actual results
P=(Count_high_results/Count_high_hospital)*100; %turns into a percent value
disp(['The model accuracy for male is: ', num2str(P), '%']);

%female
female_patients=dsa(1:47,[2,3,4,5]);
female_high_bloodpressure = categorical(female_patients.BloodPressure(:,1)>120);
features_female=dsa(1:47,[2,3,4]); % Sex feature is no longer significant 
Y2 = mnrfit(double(features_male),male_high_bloodpressure);
test2=features_female(:,:); %take all rows to test their results
check_results=mnrval(double(Y2), double(test2)); % function that shows us the chance that based on our test features the sample is in the first group or second group high/low blood pressure
results=(check_results>0.5);%change all values above 50% to be 1 and below 0- So it matches our high_bloodpressure matrix
Count_high_hospital = sum(count(cellstr(female_high_bloodpressure),'true'));
Count_high_results = sum(results(:,1)>0.5); % compares results of test to the actual results
P=(Count_high_results/Count_high_hospital)*100; %turns into a percent value
disp(['The model accuracy for female is: ', num2str(P), '%']);
