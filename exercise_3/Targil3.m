load fisheriris;
xx=meas(1:100,1:3);
iris_data = meas(:,1:3);
sp=dummyvar(categorical(species));
t=sp(1:100,:);
%[x,t]= iris_dataset;
Best=0;
best_result=100;
    for i= 5:100
        net = patternnet(i);
        result_total=0;
        for j=1:50
        net= train (net,x,t);
        y=net(x);
        result=perform( net,t,y);
        result_total= result_total + result;
       end
        result=(result_total/50);
        if result<best_result
            Best=i;
            best_result=result;
        
        end
    end
    disp(['The optimal number of neurons is: ',num2str(Best)]);

 
