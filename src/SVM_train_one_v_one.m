function [ trained_SVMs, classes ] = SVM_train_one_v_one( class_arr, train_labels, kernel_type  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    config
    M = unique(train_labels,'first');
    class_labels = [ones(7,1); -1*ones(7,1)];
    trained_SVMs = [];
    classes = {};
    counter = 1;
    comb_arr = combntns(M,2);
    for k = 1:length(comb_arr(:,1))
        i = comb_arr(k,1);
        j = comb_arr(k,2);
        pos_class_vectors = cell2mat(class_arr(i));

        neg_class_vectors = cell2mat(class_arr(j));
        train_matrix = [pos_class_vectors neg_class_vectors]';
        model_linear = svmtrain(class_labels, train_matrix, kernel_type);
        trained_SVMs = [trained_SVMs model_linear];
        classes{counter} = [i j];
        counter = counter + 1;
    end
    

end

