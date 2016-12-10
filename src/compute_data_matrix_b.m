function [ Sb ] = compute_data_matrix_b( A, training_data )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    N = length(training_data(1, :));    
    Sb = (1 / N) * A' * A;

end

