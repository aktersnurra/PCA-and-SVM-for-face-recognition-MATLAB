function [ class_PCAs, x_bars ] = PCA_per_class( train_data, x_bar )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    
    stop = length(train_data(1, :));
    counter = 1;
    train_class = [];
    class_PCAs = [];
    x_bars = [];
    test = 1;
    
    for i = 1:stop
        face_vector = train_data(:, i);
        if counter == 7
            train_class = [train_class face_vector];

            x_bar = compute_avg_face_vector(train_class);
            x_bars = [x_bars x_bar];
            
            A = compute_A( train_class, x_bar);
            
            [ Sb ] = compute_data_matrix_b( A, train_class );
            [ eigenvectors_v, ~ ] = compute_eigenvectors(Sb);
            
            eigenvectors_u = compute_eigenvectors_u( A, eigenvectors_v );
            class_PCAs = [class_PCAs eigenvectors_u];
            
            train_class = [];
            counter = 1;
            
        else
            train_class = [train_class face_vector];
            counter = counter + 1;
        end
        
    end


end

