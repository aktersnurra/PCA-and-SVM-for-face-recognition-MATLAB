function [ true_pos, false_pos  ] = nn_class_PCA( class_PCAs, x_bars, test_data, test_labels )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

    sub_space_dim = 7;
    true_pos = 0;
    false_pos = 0;
    counter = 1;
    rows = size(class_PCAs(:,1));
    eigenvectors = zeros(rows(1),7);
   
    %correct = [];
    %false = [];
    
    for unknown_face = test_data
       e = Inf;
       start = 1;
       stop = 7;
       correct_label = test_labels(counter);
       class_unknown = 0;
       counter = counter + 1;

       for class = 1:52
           eigenvectors(:,1:7) = class_PCAs(:,start:stop);
           x_bar = x_bars(:, class);
           w_unknown_face = project_test_eigspace(unknown_face, x_bar, eigenvectors, sub_space_dim);
           
           rec_unknown_face = reconstruct_face( x_bar, w_unknown_face, eigenvectors, 1 );

           e_temp = norm(unknown_face - rec_unknown_face);
           
           if e_temp < e
               e = e_temp;
               class_unknown = class;
           end
           start = start + 7;
           stop = stop + 7;
       end
       
       if class_unknown == correct_label
           true_pos = true_pos + 1;
           %correct = [correct class_unknown];
       else
           false_pos = false_pos + 1;
           %false = [false class_unknown];
       end  
       
    end

end

