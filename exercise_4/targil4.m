load ionosphere;
first_254=X(1:254,:);
tags_254=Y(1:254);

training_set_size=round(length(first_254)*0.7);
training_set=first_254(1:training_set_size,:);
tags_training=tags_254(1:training_set_size);

test_set_size=round(length(first_254)*0.3);
test_set=first_254(training_set_size:254,:);
tags_test=tags_254(training_set_size:254,:);

SVMModel = fitcsvm(training_set,tags_training);
SVMModelG = fitcsvm(training_set,tags_training,'KernelFunction','gaussian');
SVMModelL = fitcsvm(training_set,tags_training,'KernelFunction','linear');
SVMModelR = fitcsvm(training_set,tags_training,'KernelFunction','rbf');

Linear=evaluate_model(SVMModelL,test_set,tags_test);
Gaussian=evaluate_model(SVMModelG,test_set,tags_test);
Radial=evaluate_model(SVMModelR,test_set,tags_test);

fprintf(['The F1 score for linear kernel is: ', num2str(Linear), '\n',...
    'for radial kernel: ',num2str(Radial), '\nand for gaussian kernel: ', num2str(Gaussian), '\n'])


function F1 = evaluate_model(SVMModel,test_set,test_set_tags)
    label = predict(SVMModel,test_set)
    predicted_good= strcmp(label,'g')
    predicted_bad= strcmp(label,'b')
    good=length(predicted_good)
    bad=length(predicted_bad)
    good_real= strcmp(test_set_tags,'g')
    bad_real =strcmp(test_set_tags,'b');
    % Calculate precision, recall, TPR, FPR and F1 score.
    TP = sum(predicted_good(good_real) == 1)
    TN = sum(predicted_bad(bad_real) == 1)
    FP=good-TP
    FN= bad-TN
    Precision = TP/(TP+FP);
    Recall = TP/(TP+FN);
    F1 = 2 * Recall * Precision / (Recall + Precision); 
end



