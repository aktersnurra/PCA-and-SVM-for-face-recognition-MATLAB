function [ TP, FP ] = test_SVM_one_v_rest( trained_SVMs, classes, test_data, test_labels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    config
    TP = 0;
    FP = 0;
    l = 1;
    t = 1;
    for unknown_face = test_data
        unknown_label = test_labels(l);
        l = l + 1;
        y_norm_max = - Inf;
        y_arr = [];
        for SVM = trained_SVMs
            [~, ~, y] = svmpredict(0, unknown_face', SVM, '-q');
            %{
            w = SVM.SVs' * SVM.sv_coef;
            b = -SVM.rho;
            y = w' * unknown_face + b;
            %}
            y_arr = [y_arr y];
        end
        
        %if t == 1
        %    t = 2;
        %    y_arr
        %end
        
        y_max = max(y_arr);
        y_min = min(y_arr);
        counter = 1;
        for y = y_arr
           y_norm = (y - y_min)/(y_max - y_min);
           if y_norm > y_norm_max
                y_norm_max = y_norm;
                m = cell2mat(classes(counter));
                pred_class = m(1);
           end
           counter = counter + 1;
        end
        
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

