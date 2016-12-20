function [ votes, TP, FP ] = test_SVM_one_v_one( trained_SVMs, classes, test_data, test_labels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    TP = 0;
    FP = 0;
    l = 1;
    votes = [];
    for unknown_face = test_data
        unknown_label = test_labels(l);
        voting = zeros(length(unique(test_labels,'first')),1);
        l = l + 1;
        counter = 1;
        for SVM = trained_SVMs
            %w = SVM.SVs' * SVM.sv_coef;
            %b = -SVM.rho;
            %y = w' * unknown_face + b;
            [~, ~, y] = svmpredict(0, unknown_face', SVM, '-q');
            m = cell2mat(classes(counter));
            if y > 0
               assigned_class = m(1);
               voting(assigned_class) = voting(assigned_class) + 1;
            else
               assigned_class = m(2);
               voting(assigned_class) = voting(assigned_class) + 1;
            end
            counter = counter + 1;
        end
        
        votes = [votes voting];
        [~, pred_class] = max(voting(:));
        if pred_class == unknown_label
            TP = TP + 1;
        else
            FP = FP + 1;
        end
       
    end
    TP
    FP
    acc = TP /(FP + TP) * 100
end

