function [ trained_SVMs, classes ] = SVM_train_one_v_rest( class_arr, train_labels, kernel_type  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    config
    M = unique(train_labels,'first');
    neg_class_labels = (length(M) - 1) * 7;
    class_labels = [ones(7,1); -1*ones(neg_class_labels,1)];
    trained_SVMs = [];
    classes = {};
    counter = 1;
    
    for i = M
        pos_class_vectors = cell2mat(class_arr(i));
        neg_class_ind = M(find(M~=i));
        neg_class_vectors = cell2mat(class_arr(neg_class_ind));
        train_matrix = [pos_class_vectors neg_class_vectors]';
        model = svmtrain(class_labels, train_matrix, kernel_type);
        trained_SVMs = [trained_SVMs model];
        classes{counter} = i;
        counter = counter + 1;
    end
    

end

