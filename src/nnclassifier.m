function [ true_pos false_pos ] = nnclassifier( w_unknowns, unknown_labels, w, labels )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    true_pos = 0;
    false_pos = 0;
    num_of_training = 6;
    counter = 1;
    L = length(w_unknowns(:, 1));
    N = length(w(1, :));
    M = length(unknown_labels);
    labels_true = [];
    labels_false = [];
    
    for j = 1:M
        e = Inf;
        e_temp = 0;
        w_unknown = w_unknowns(:, j);
        unknown_label = unknown_labels(j);
        for i = 1:N
           w_n = w(1:L, i);
           %e_temp = e_temp + norm(w_unknown - w_n);
           e_temp = norm(w_unknown - w_n);
           %if counter == num_of_training
               counter = 1;
               if e_temp < e
                   e = e_temp;
                   label = labels(i);
               end
               e_temp = 0;
           %end
           counter = counter + 1;
        end

        if label == unknown_label
            labels_true = [labels_true label];
            true_pos = true_pos + 1;
        end
        
        if label ~= unknown_label
            labels_false = [labels_false label];
            false_pos = false_pos + 1;
        end    
    end
    labels_true
    labels_false
    
end
    



