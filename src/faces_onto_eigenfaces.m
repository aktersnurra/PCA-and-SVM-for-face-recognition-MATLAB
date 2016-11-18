function [ w ] = faces_onto_eigenfaces( A, eigenvectors, sub_space_dim )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    start = 1;
    stop = length(A(1,:));
    w = [];
    for i = start:stop
        phi = A(:,i);
        w_n = [];
        for k = start:sub_space_dim
           u = eigenvectors(:, k);
           a_ni = phi' * u;
           w_n = [w_n a_ni];
        end
        w(:, i) = w_n;
        
    end


end

