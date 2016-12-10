function [ class_PCAs, x_bars ] = PCA_per_class( train_data )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    
    stop = length(train_data(1, :));
    counter = 1;
    train_class = [];
    class_PCAs = [];
    x_bars = [];
    
    for i = 1:stop
        face_vector = train_data(:, i);
        if counter == 7
            x_bar = compute_avg_face_vector(train_class);
            x_bars = [x_bars x_bar];
            
            [ ~, S ] = compute_covariance_matrix(train_class, x_bar);
            [ eigenvectors, ~ ] = compute_eigenvectors(S);
            
            class_PCAs = [class_PCAs eigenvectors];
            
            train_class = [];
            counter = 1;
        else
            train_class = [train_class face_vector];
            counter = counter + 1;
        end
        
    end

end

